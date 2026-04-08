import '../datasource/remote/api_client.dart';
import '../database/app_database.dart' as db;
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
  final db.AppDatabase _db; // Keeping for potential other usages, but not for Shift sync

  ShiftRepository(this._apiClient, this._db);

  @override
  Future<ShiftModel?> getActiveShift(int userId) async {
    try {
      final response = await _apiClient.authenticatedDio.get('/shifts/active');
      if (response.data['data'] != null) {
        return ShiftModel.fromJson(response.data['data']);
      }
    } catch (e) {
      // If error (e.g. 404 or network error), we return null
      // Cubit will handle the "no active shift" state
    }
    return null;
  }

  @override
  Future<void> openShift(int userId, double initialCash, String? notes) async {
    await _apiClient.authenticatedDio.post(
      '/shifts/open',
      data: {'cash_in': initialCash, 'notes': notes},
    );
  }

  @override
  Future<void> closeShift(int id, double finalCash, String? notes) async {
    await _apiClient.authenticatedDio.post(
      '/shifts/close',
      data: {'cash_out': finalCash, 'notes': notes},
    );
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

  @override
  Future<void> updateShiftNotes(int id, String notes) async {
    try {
      await _apiClient.authenticatedDio.patch(
        '/shifts/$id/notes',
        data: {'notes': notes},
      );
    } catch (e) {
      rethrow;
    }
  }
}
