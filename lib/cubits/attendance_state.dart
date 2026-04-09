import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/attendance.dart';

part 'attendance_state.freezed.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    @Default(false) bool isLoading,
    AttendanceModel? todayAttendance,
    @Default([]) List<AttendanceModel> history,
    String? error,
  }) = _AttendanceState;
}
