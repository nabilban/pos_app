// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceModelImpl(
  id: (json['ID'] as num?)?.toInt(),
  userId: (json['user_id'] as num).toInt(),
  checkInTime: DateTime.parse(json['check_in_time'] as String),
  checkOutTime: json['check_out_time'] == null
      ? null
      : DateTime.parse(json['check_out_time'] as String),
  photoPath: json['photo_path'] as String?,
  syncStatus: json['syncStatus'] as String? ?? 'pending',
);

Map<String, dynamic> _$$AttendanceModelImplToJson(
  _$AttendanceModelImpl instance,
) => <String, dynamic>{
  'ID': instance.id,
  'user_id': instance.userId,
  'check_in_time': instance.checkInTime.toIso8601String(),
  'check_out_time': instance.checkOutTime?.toIso8601String(),
  'photo_path': instance.photoPath,
  'syncStatus': instance.syncStatus,
};
