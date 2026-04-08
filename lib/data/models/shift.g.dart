// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftModelImpl _$$ShiftModelImplFromJson(Map<String, dynamic> json) =>
    _$ShiftModelImpl(
      id: (json['ID'] as num?)?.toInt(),
      userId: (json['user_id'] as num).toInt(),
      cashIn: (json['cash_in'] as num).toDouble(),
      cashOut: (json['cash_out'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      status: json['status'] as String? ?? 'open',
      syncStatus: json['syncStatus'] as String? ?? 'pending',
    );

Map<String, dynamic> _$$ShiftModelImplToJson(_$ShiftModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'user_id': instance.userId,
      'cash_in': instance.cashIn,
      'cash_out': instance.cashOut,
      'notes': instance.notes,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'status': instance.status,
      'syncStatus': instance.syncStatus,
    };
