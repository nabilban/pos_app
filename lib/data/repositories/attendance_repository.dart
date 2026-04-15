import 'package:dio/dio.dart';
import '../datasource/remote/api_client.dart';
import '../database/app_database.dart' as db;
import '../datasource/local/local_cache_store.dart';
import '../models/attendance.dart';

abstract class IAttendanceRepository {
  Future<AttendanceModel?> getTodayAttendance(int userId);
  Future<void> checkIn(int userId, String photoPath);
  Future<void> checkOut(int attendanceId, String photoPath);
  Future<List<AttendanceModel>> getHistory();
}

class AttendanceRepository implements IAttendanceRepository {
  final ApiClient _apiClient;
  // ignore: unused_field
  final db.AppDatabase _db;
  final LocalCacheStore _cache;

  static const _todayAttendanceKey = 'attendance_today';
  static const _attendanceHistoryKey = 'attendance_history';

  AttendanceRepository(this._apiClient, this._db, this._cache);

  @override
  Future<AttendanceModel?> getTodayAttendance(int userId) async {
    try {
      final response = await _apiClient.authenticatedDio.get(
        '/attendances/today',
        data: {'user_id': userId.toString()},
      );
      if (response.data['data'] != null) {
        final attendance = AttendanceModel.fromJson(
          Map<String, dynamic>.from(response.data['data']),
        );
        await _cache.saveObject(_todayAttendanceKey, attendance.toJson());
        return attendance;
      }
      await _cache.saveObject(_todayAttendanceKey, null);
      return null;
    } catch (_) {
      final cached = await _cache.readObject(_todayAttendanceKey);
      if (cached != null) {
        return AttendanceModel.fromJson(cached);
      }
      return null;
    }
  }

  @override
  Future<void> checkIn(int userId, String photoPath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photoPath, filename: 'selfie.jpg'),
    });

    await _apiClient.authenticatedDio.post(
      '/attendances/checkin',
      data: formData,
    );

    final today = await getTodayAttendance(userId);
    if (today != null) {
      final history = await getHistory();
      final merged = [today, ...history.where((h) => h.id != today.id)];
      await _cache.saveList(
        _attendanceHistoryKey,
        merged.map((e) => e.toJson()).toList(growable: false),
      );
    }
  }

  @override
  Future<void> checkOut(int attendanceId, String photoPath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        photoPath,
        filename: 'selfie_out.jpg',
      ),
    });

    await _apiClient.authenticatedDio.post(
      '/attendances/$attendanceId/checkout',
      data: formData,
    );
  }

  @override
  Future<List<AttendanceModel>> getHistory() async {
    try {
      final response = await _apiClient.authenticatedDio.get(
        '/attendances/history',
      );
      final List data = response.data['data'] ?? [];
      final history = data
          .map(
            (json) => AttendanceModel.fromJson(Map<String, dynamic>.from(json)),
          )
          .toList();
      await _cache.saveList(
        _attendanceHistoryKey,
        history.map((e) => e.toJson()).toList(growable: false),
      );
      return history;
    } catch (_) {
      final cached = await _cache.readList(_attendanceHistoryKey);
      if (cached.isNotEmpty) {
        return cached.map(AttendanceModel.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }
}
