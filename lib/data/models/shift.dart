// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift.freezed.dart';
part 'shift.g.dart';

@freezed
class ShiftModel with _$ShiftModel {
  const factory ShiftModel({
    @JsonKey(name: 'ID') required int? id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'cash_in') required double cashIn,
    @JsonKey(name: 'cash_out') double? cashOut,
    String? notes,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @Default('open') String status,
    @Default('pending') String syncStatus,
  }) = _ShiftModel;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(json);
}
