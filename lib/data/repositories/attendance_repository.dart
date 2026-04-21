import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import '../datasource/remote/api_client.dart';
import '../database/app_database.dart';
import '../models/attendance.dart';

abstract class IAttendanceRepository {
  Future<AttendanceModel?> getTodayAttendance(int userId);
  Future<void> checkIn(int userId, String photoPath);
  Future<void> checkOut(int attendanceId, String photoPath);
  Future<List<AttendanceModel>> getHistory();
}

class AttendanceRepository implements IAttendanceRepository {
  final ApiClient _apiClient;
  final AppDatabase _db;

  AttendanceRepository(this._apiClient, this._db);

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
        
        await _db.saveAttendance(AttendancesCompanion.insert(
          id: Value(attendance.id),
          userId: attendance.userId,
          photoIn: Value(attendance.photoIn),
          photoOut: Value(attendance.photoOut),
          checkIn: Value(attendance.checkIn),
          checkOut: Value(attendance.checkOut),
          syncStatus: Value(attendance.syncStatus),
        ));
        
        return attendance;
      }
      
      return await _fetchLocalTodayAttendance(userId);
    } catch (_) {
      return await _fetchLocalTodayAttendance(userId);
    }
  }

  Future<AttendanceModel?> _fetchLocalTodayAttendance(int userId) async {
    final today = await _db.getTodayAttendance(userId);
    if (today != null) {
      return AttendanceModel(
        id: today.id,
        userId: today.userId,
        photoIn: today.photoIn,
        photoOut: today.photoOut,
        checkIn: today.checkIn,
        checkOut: today.checkOut,
        syncStatus: today.syncStatus,
      );
    }
    return null;
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
    await getTodayAttendance(userId);
  }

  @override
  Future<void> checkOut(int attendanceId, String photoPath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photoPath, filename: 'selfie_out.jpg'),
    });

    await _apiClient.authenticatedDio.post(
      '/attendances/$attendanceId/checkout',
      data: formData,
    );
  }

  @override
  Future<List<AttendanceModel>> getHistory() async {
    try {
      final response =
          await _apiClient.authenticatedDio.get('/attendances/history');
      final List data = response.data['data'] ?? [];
      final history = data
          .map(
            (json) => AttendanceModel.fromJson(Map<String, dynamic>.from(json)),
          )
          .toList();

      // Cache history locally
      for (final attendance in history) {
        await _db.saveAttendanceHistory(AttendanceHistoriesCompanion.insert(
          id: Value(attendance.id),
          userId: attendance.userId,
          photoIn: Value(attendance.photoIn),
          photoOut: Value(attendance.photoOut),
          checkIn: Value(attendance.checkIn),
          checkOut: Value(attendance.checkOut),
          syncStatus: Value(attendance.syncStatus),
        ));
      }

      return history;
    } catch (_) {
      final entities = await _db.getAttendanceHistory();
      return entities
          .map(
            (e) => AttendanceModel(
              id: e.id,
              userId: e.userId,
              photoIn: e.photoIn,
              photoOut: e.photoOut,
              checkIn: e.checkIn,
              checkOut: e.checkOut,
              syncStatus: e.syncStatus,
            ),
          )
          .toList();
    }
  }
}
