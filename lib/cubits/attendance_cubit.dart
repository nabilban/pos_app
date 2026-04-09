import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/attendance_repository.dart';
import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final IAttendanceRepository _repository;

  AttendanceCubit(this._repository) : super(const AttendanceState());

  Future<void> checkStatus(int userId) async {
    if (state.isLoading) return;
    
    // Only show global loading if we have no attendance data yet
    final showLoading = state.todayAttendance == null;
    if (showLoading) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      final attendance = await _repository.getTodayAttendance(userId);
      emit(state.copyWith(isLoading: false, todayAttendance: attendance));
      // Also load history to be sure
      await loadHistory();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadHistory() async {
    try {
      final history = await _repository.getHistory();
      emit(state.copyWith(history: history));
    } catch (e) {
      // Slient fail for history load to not block UI
    }
  }

  Future<void> checkIn(int userId, String photoPath) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.checkIn(userId, photoPath);
      final attendance = await _repository.getTodayAttendance(userId);
      emit(state.copyWith(isLoading: false, todayAttendance: attendance));
      await loadHistory();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> checkOut(int attendanceId, int userId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.checkOut(attendanceId);
      final attendance = await _repository.getTodayAttendance(userId);
      emit(state.copyWith(isLoading: false, todayAttendance: attendance));
      await loadHistory();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
