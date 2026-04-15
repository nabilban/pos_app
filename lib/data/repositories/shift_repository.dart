import '../datasource/remote/api_client.dart';
import '../database/app_database.dart' as db;
import '../datasource/local/local_cache_store.dart';
import '../models/shift.dart';

abstract class IShiftRepository {
  Future<ShiftModel?> getActiveShift(int userId);
  Future<void> openShift(int userId, double initialCash, String? notes);
  Future<void> closeShift(int id, double finalCash, String? notes);
  Future<List<ShiftModel>> getHistory();
  Future<void> updateShiftNotes(int id, String notes);
}

class ShiftRepository implements IShiftRepository {
  final ApiClient _apiClient;
  // ignore: unused_field
  final db.AppDatabase _db;
  final LocalCacheStore _cache;

  static const _activeShiftKey = 'shift_active';
  static const _shiftHistoryKey = 'shift_history';

  ShiftRepository(this._apiClient, this._db, this._cache);

  @override
  Future<ShiftModel?> getActiveShift(int userId) async {
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/active');
      if (response.data['data'] != null) {
        final shift = ShiftModel.fromJson(
          Map<String, dynamic>.from(response.data['data']),
        );
        await _cache.saveObject(_activeShiftKey, shift.toJson());
        return shift;
      }
      await _cache.saveObject(_activeShiftKey, null);
      return null;
    } catch (_) {
      final cached = await _cache.readObject(_activeShiftKey);
      if (cached != null) {
        return ShiftModel.fromJson(cached);
      }
      return null;
    }
  }

  @override
  Future<void> openShift(int userId, double initialCash, String? notes) async {
    await _apiClient.authenticatedDio.post(
      '/shifts/open',
      data: {'cash_in': initialCash, 'notes': notes},
    );

    final active = await getActiveShift(userId);
    if (active != null) {
      final history = await getHistory();
      final merged = [active, ...history.where((h) => h.id != active.id)];
      await _cache.saveList(
        _shiftHistoryKey,
        merged.map((e) => e.toJson()).toList(growable: false),
      );
    }
  }

  @override
  Future<void> closeShift(int id, double finalCash, String? notes) async {
    await _apiClient.authenticatedDio.post(
      '/shifts/close',
      data: {'cash_out': finalCash, 'notes': notes},
    );
    await _cache.saveObject(_activeShiftKey, null);
  }

  @override
  Future<List<ShiftModel>> getHistory() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/history');
      final List data = response.data['data'] ?? [];
      final history = data
          .map((json) => ShiftModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      await _cache.saveList(
        _shiftHistoryKey,
        history.map((e) => e.toJson()).toList(growable: false),
      );
      return history;
    } catch (_) {
      final cached = await _cache.readList(_shiftHistoryKey);
      if (cached.isNotEmpty) {
        return cached.map(ShiftModel.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }

  @override
  Future<void> updateShiftNotes(int id, String notes) async {
    try {
      await _apiClient.authenticatedDio.patch(
        '/shifts/$id/notes',
        data: {'notes': notes},
      );

      final history = await getHistory();
      await _cache.saveList(
        _shiftHistoryKey,
        history.map((e) => e.toJson()).toList(growable: false),
      );
    } catch (_) {
      rethrow;
    }
  }
}
