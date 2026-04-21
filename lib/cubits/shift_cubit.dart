import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/data/models/attendance.dart';
import 'package:pos_app/data/models/shift.dart';
import '../data/repositories/shift_repository.dart';
import '../data/repositories/attendance_repository.dart';
import 'shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  final IShiftRepository _repository;
  final IAttendanceRepository _attendanceRepository;

  ShiftCubit(this._repository, this._attendanceRepository)
    : super(const ShiftState());

  Future<void> checkStatus(int userId) async {
    if (state.isLoading) return;

    // Only show global loading if we have no active shift yet
    final showLoading = state.activeShift == null;
    if (showLoading) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      final results = await Future.wait([
        _repository.getActiveShift(userId),
        _repository.getHistory(),
        _attendanceRepository.getTodayAttendance(userId),
        _attendanceRepository.getHistory(),
      ]);

      emit(
        state.copyWith(
          isLoading: false,
          activeShift: results[0] as ShiftModel?,
          history: results[1] as List<ShiftModel>,
          todayAttendance: results[2] as AttendanceModel?,
          attendanceHistory: results[3] as List<AttendanceModel>,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadHistory() async {
    try {
      final results = await Future.wait([
        _repository.getHistory(),
        _attendanceRepository.getHistory(),
      ]);
      emit(
        state.copyWith(
          history: results[0] as List<ShiftModel>,
          attendanceHistory: results[1] as List<AttendanceModel>,
        ),
      );
    } catch (e) {
      // Keep existing history on error
    }
  }

  void setTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  Future<void> openShift(int userId, double initialCash, String? notes) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.openShift(userId, initialCash, notes);
      final shift = await _repository.getActiveShift(userId);
      emit(state.copyWith(isLoading: false, activeShift: shift));
      loadHistory(); // Refresh history
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> closeShift(
    int id,
    int userId,
    double finalCash,
    String? notes,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.closeShift(id, finalCash, notes);
      final shift = await _repository.getActiveShift(userId);
      emit(state.copyWith(isLoading: false, activeShift: shift));
      loadHistory(); // Refresh history
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateNotes(int id, String notes) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.updateShiftNotes(id, notes);
      await loadHistory();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
