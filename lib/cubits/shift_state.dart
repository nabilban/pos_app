import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/shift.dart';

part 'shift_state.freezed.dart';

@freezed
class ShiftState with _$ShiftState {
  const factory ShiftState({
    @Default(false) bool isLoading,
    ShiftModel? activeShift,
    String? error,
  }) = _ShiftState;
}
