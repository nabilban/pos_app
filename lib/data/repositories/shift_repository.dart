import '../datasource/remote/api_client.dart';
import '../database/app_database.dart';
import '../models/shift.dart';
import 'package:drift/drift.dart';

abstract class IShiftRepository {
  Future<ShiftModel?> getActiveShift(int userId);
  Future<void> openShift(int userId, double initialCash, String? notes);
  Future<void> closeShift(int id, double finalCash, String? notes);
  Future<List<ShiftModel>> getHistory();
  Future<void> updateShiftNotes(int id, String notes);
}

class ShiftRepository implements IShiftRepository {
  final ApiClient _apiClient;
  final AppDatabase _db;

  ShiftRepository(this._apiClient, this._db);

  @override
  Future<ShiftModel?> getActiveShift(int userId) async {
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/active');
      if (response.data['data'] != null) {
        final shift = ShiftModel.fromJson(
          Map<String, dynamic>.from(response.data['data']),
        );
        
        await _db.saveShift(ShiftsCompanion.insert(
          id: Value(shift.id),
          userId: shift.userId,
          cashIn: shift.cashIn,
          cashOut: Value(shift.cashOut),
          notes: Value(shift.notes),
          startTime: shift.startTime,
          endTime: Value(shift.endTime),
          status: Value(shift.status),
          syncStatus: Value(shift.syncStatus),
        ));
        
        return shift;
      }
      
      return await _fetchLocalActiveShift(userId);
    } catch (_) {
      return await _fetchLocalActiveShift(userId);
    }
  }

  Future<ShiftModel?> _fetchLocalActiveShift(int userId) async {
    final active = await _db.getActiveShift(userId);
    if (active != null) {
      return ShiftModel(
        id: active.id,
        userId: active.userId,
        cashIn: active.cashIn,
        cashOut: active.cashOut,
        notes: active.notes,
        startTime: active.startTime,
        endTime: active.endTime,
        status: active.status,
        syncStatus: active.syncStatus,
      );
    }
    return null;
  }

  @override
  Future<void> openShift(int userId, double initialCash, String? notes) async {
    await _apiClient.authenticatedDio.post(
      '/shifts/open',
      data: {'cash_in': initialCash, 'notes': notes},
    );
    await getActiveShift(userId);
  }

  @override
  Future<void> closeShift(int id, double finalCash, String? notes) async {
    await _apiClient.authenticatedDio.post(
      '/shifts/close',
      data: {'cash_out': finalCash, 'notes': notes},
    );
    await _db.updateShift(id, ShiftsCompanion(
      status: const Value('closed'),
      cashOut: Value(finalCash),
      notes: Value(notes),
      endTime: Value(DateTime.now()),
    ));
  }

  @override
  Future<List<ShiftModel>> getHistory() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/history');
      final List data = response.data['data'] ?? [];
      final history = data
          .map((json) => ShiftModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      return history;
    } catch (_) {
      final entities = await _db.getShiftHistory();
      return entities.map((e) => ShiftModel(
        id: e.id,
        userId: e.userId,
        cashIn: e.cashIn,
        cashOut: e.cashOut,
        notes: e.notes,
        startTime: e.startTime,
        endTime: e.endTime,
        status: e.status,
        syncStatus: e.syncStatus,
      )).toList();
    }
  }

  @override
  Future<void> updateShiftNotes(int id, String notes) async {
    try {
      await _apiClient.authenticatedDio.patch(
        '/shifts/$id/notes',
        data: {'notes': notes},
      );
      await _db.updateShift(id, ShiftsCompanion(notes: Value(notes)));
    } catch (_) {
      // Still update local even on sync failure
      await _db.updateShift(id, ShiftsCompanion(notes: Value(notes)));
      rethrow;
    }
  }
}
