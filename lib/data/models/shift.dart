import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift.freezed.dart';
part 'shift.g.dart';

@freezed
class ShiftModel with _$ShiftModel {
  const factory ShiftModel({
    required int? id,
    required int userId,
    required double cashIn,
    double? cashOut,
    String? notes,
    required DateTime startTime,
    DateTime? endTime,
    @Default('open') String status,
    @Default('pending') String syncStatus,
  }) = _ShiftModel;

  factory ShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftModelFromJson(json);
}
