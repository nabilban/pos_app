import 'package:dio/dio.dart';
import '../datasource/remote/api_client.dart';
import '../database/app_database.dart' as db;
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
  final db.AppDatabase _db; // Keeping consistency for constructor, but not for sync

  AttendanceRepository(this._apiClient, this._db);

  @override
  Future<AttendanceModel?> getTodayAttendance(int userId) async {
    try {
      final response = await _apiClient.authenticatedDio.get(
        '/attendances/today',
        data: {'user_id': userId.toString()},
      );
      if (response.data['data'] != null) {
        return AttendanceModel.fromJson(response.data['data']);
      }
    } catch (e) {
      // If error (e.g. 404 or network error), we return null
    }
    return null;
  }

  @override
  Future<void> checkIn(int userId, String photoPath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        photoPath,
        filename: 'selfie.jpg',
      ),
    });

    await _apiClient.authenticatedDio.post(
      '/attendances/checkin',
      data: formData,
    );
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
      final response = await _apiClient.authenticatedDio.get('/attendances/history');
      final List data = response.data['data'] ?? [];
      return data.map((json) => AttendanceModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
