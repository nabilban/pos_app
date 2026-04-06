import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import '../datasource/remote/api_client.dart';
import '../database/app_database.dart' as db;
import '../models/attendance.dart';

abstract class IAttendanceRepository {
  Future<AttendanceModel?> getTodayAttendance(int userId);
  Future<void> checkIn(int userId, String photoPath);
  Future<void> checkOut(int attendanceId);
  Future<List<AttendanceModel>> getHistory();
}

class AttendanceRepository implements IAttendanceRepository {
  final ApiClient _apiClient;
  final db.AppDatabase _db;

  AttendanceRepository(this._apiClient, this._db);

  @override
  Future<AttendanceModel?> getTodayAttendance(int userId) async {
    // 1. Check local DB first
    final local = await _db.getTodayAttendance(userId);
    if (local != null) {
      return _mapToModel(local);
    }

    // 2. Try fetching from API if not found locally
    try {
      final response = await _apiClient.authenticatedDio.get('/attendances/today');
      if (response.data['data'] != null) {
        final apiData = response.data['data'];
        // Save to local DB for offline access
        final companion = db.AttendancesCompanion.insert(
          userId: userId,
          checkInTime: DateTime.parse(apiData['check_in_time']),
          checkOutTime: apiData['check_out_time'] != null 
              ? Value(DateTime.parse(apiData['check_out_time'])) 
              : const Value.absent(),
          photoPath: Value(apiData['photo_url']),
          syncStatus: const Value('synced'),
          updatedAt: Value(DateTime.now()),
        );
        await _db.saveAttendance(companion);
        return AttendanceModel.fromJson(apiData);
      }
    } catch (e) {
      // If API fails, we just return null (already checked local)
    }
    return null;
  }

  @override
  Future<void> checkIn(int userId, String photoPath) async {
    final now = DateTime.now();
    
    // 1. Save locally first
    final id = await _db.saveAttendance(db.AttendancesCompanion.insert(
      userId: userId,
      checkInTime: now,
      photoPath: Value(photoPath),
      syncStatus: const Value('pending'),
      updatedAt: Value(now),
    ));

    // 2. Try syncing with API
    try {
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(photoPath, filename: 'selfie.jpg'),
      });

      await _apiClient.authenticatedDio.post(
        '/attendances/checkin',
        data: formData,
      );

      // 3. Mark as synced
      await _db.updateAttendance(id, const db.AttendancesCompanion(
        syncStatus: Value('synced'),
      ));
    } catch (e) {
      // Keep as pending for background sync later
    }
  }

  @override
  Future<void> checkOut(int attendanceId) async {
    final now = DateTime.now();

    // 1. Update locally
    await _db.updateAttendance(attendanceId, db.AttendancesCompanion(
      checkOutTime: Value(now),
      syncStatus: const Value('pending'),
      updatedAt: Value(now),
    ));

    // 2. Try syncing with API
    try {
      await _apiClient.authenticatedDio.post('/attendances/$attendanceId/checkout');
      
      // 3. Mark as synced
      await _db.updateAttendance(attendanceId, const db.AttendancesCompanion(
        syncStatus: Value('synced'),
      ));
    } catch (e) {
      // Keep as pending
    }
  }

  @override
  Future<List<AttendanceModel>> getHistory() async {
    // For simplicity, we fetch from API for history, 
    // or we could show local history if available.
    try {
      final response = await _apiClient.authenticatedDio.get('/attendances/history');
      final List data = response.data['data'] ?? [];
      return data.map((json) => AttendanceModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  AttendanceModel _mapToModel(db.Attendance entity) {
    return AttendanceModel(
      id: entity.id,
      userId: entity.userId,
      checkInTime: entity.checkInTime,
      checkOutTime: entity.checkOutTime,
      photoPath: entity.photoPath,
      syncStatus: entity.syncStatus,
    );
  }
}
