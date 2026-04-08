import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/shift.dart';
import '../data/models/shift_summary.dart';

part 'shift_state.freezed.dart';

@freezed
class ShiftState with _$ShiftState {
  const factory ShiftState({
    @Default(false) bool isLoading,
    ShiftModel? activeShift,
    @Default([]) List<ShiftModel> history,
    @Default(0) int selectedTab, // 0: Shift, 1: Absensi
    String? error,
    ShiftSummaryModel? selectedSummary,
    @Default(false) bool isSummaryLoading,
  }) = _ShiftState;
}
