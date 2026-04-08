// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftSummaryModelImpl _$$ShiftSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$ShiftSummaryModelImpl(
  shift: ShiftModel.fromJson(json['shift'] as Map<String, dynamic>),
  totalSales: (json['total_sales'] as num).toDouble(),
  totalTrx: (json['total_trx'] as num).toInt(),
);

Map<String, dynamic> _$$ShiftSummaryModelImplToJson(
  _$ShiftSummaryModelImpl instance,
) => <String, dynamic>{
  'shift': instance.shift,
  'total_sales': instance.totalSales,
  'total_trx': instance.totalTrx,
};
