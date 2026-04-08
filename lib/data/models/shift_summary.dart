import 'package:freezed_annotation/freezed_annotation.dart';
import 'shift.dart';

part 'shift_summary.freezed.dart';
part 'shift_summary.g.dart';

@freezed
class ShiftSummaryModel with _$ShiftSummaryModel {
  const factory ShiftSummaryModel({
    required ShiftModel shift,
    @JsonKey(name: 'total_sales') required double totalSales,
    @JsonKey(name: 'total_trx') required int totalTrx,
  }) = _ShiftSummaryModel;

  factory ShiftSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftSummaryModelFromJson(json);
}
