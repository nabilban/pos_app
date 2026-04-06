import 'package:drift/drift.dart';
import '../datasource/remote/api_client.dart';
import '../database/app_database.dart' as db;
import '../models/shift.dart';

abstract class IShiftRepository {
  Future<ShiftModel?> getActiveShift(int userId);
  Future<void> openShift(int userId, double initialCash, String? notes);
  Future<void> closeShift(int id, double finalCash, String? notes);
  Future<List<ShiftModel>> getHistory();
}

class ShiftRepository implements IShiftRepository {
  final ApiClient _apiClient;
  final db.AppDatabase _db;

  ShiftRepository(this._apiClient, this._db);

  @override
  Future<ShiftModel?> getActiveShift(int userId) async {
    // 1. Check local DB first
    final local = await _db.getActiveShift(userId);
    if (local != null) {
      return _mapToModel(local);
    }

    // 2. Try fetching from API if not found locally
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/active');
      if (response.data['data'] != null) {
        final apiData = response.data['data'];
        // Save to local DB for offline access
        final companion = db.ShiftsCompanion.insert(
          userId: userId,
          cashIn: (apiData['cash_in'] as num).toDouble(),
          cashOut: apiData['cash_out'] != null 
              ? Value((apiData['cash_out'] as num).toDouble()) 
              : const Value.absent(),
          startTime: DateTime.parse(apiData['start_time']),
          endTime: apiData['end_time'] != null 
              ? Value(DateTime.parse(apiData['end_time'])) 
              : const Value.absent(),
          status: const Value('open'),
          syncStatus: const Value('synced'),
          notes: Value(apiData['notes']),
          updatedAt: Value(DateTime.now()),
        );
        await _db.saveShift(companion);
        return ShiftModel.fromJson(apiData);
      }
    } catch (e) {
      // Return null if offline
    }
    return null;
  }

  @override
  Future<void> openShift(int userId, double initialCash, String? notes) async {
    final now = DateTime.now();
    
    // 1. Save locally first
    final id = await _db.saveShift(db.ShiftsCompanion.insert(
      userId: userId,
      cashIn: initialCash,
      startTime: now,
      notes: Value(notes),
      status: const Value('open'),
      syncStatus: const Value('pending'),
      updatedAt: Value(now),
    ));

    // 2. Try syncing with API
    try {
      await _apiClient.authenticatedDio.post(
        '/shifts/open',
        data: {
          'cash_in': initialCash,
          'notes': notes,
        },
      );

      // 3. Mark as synced
      await _db.updateShift(id, const db.ShiftsCompanion(
        syncStatus: Value('synced'),
      ));
    } catch (e) {
      // Keep as pending
    }
  }

  @override
  Future<void> closeShift(int id, double finalCash, String? notes) async {
    final now = DateTime.now();

    // 1. Update locally
    await _db.updateShift(id, db.ShiftsCompanion(
      cashOut: Value(finalCash),
      endTime: Value(now),
      notes: Value(notes),
      status: const Value('closed'),
      syncStatus: const Value('pending'),
      updatedAt: Value(now),
    ));

    // 2. Try syncing with API
    try {
      await _apiClient.authenticatedDio.post(
        '/shifts/close',
        data: {
          'cash_out': finalCash,
          'notes': notes,
        },
      );
      
      // 3. Mark as synced
      await _db.updateShift(id, const db.ShiftsCompanion(
        syncStatus: Value('synced'),
      ));
    } catch (e) {
      // Keep as pending
    }
  }

  @override
  Future<List<ShiftModel>> getHistory() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/history');
      final List data = response.data['data'] ?? [];
      return data.map((json) => ShiftModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  ShiftModel _mapToModel(db.Shift entity) {
    return ShiftModel(
      id: entity.id,
      userId: entity.userId,
      cashIn: entity.cashIn,
      cashOut: entity.cashOut,
      notes: entity.notes,
      startTime: entity.startTime,
      endTime: entity.endTime,
      status: entity.status,
      syncStatus: entity.syncStatus,
    );
  }
}
