// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceModelImpl(
  id: (json['id'] as num?)?.toInt(),
  userId: (json['userId'] as num).toInt(),
  checkInTime: DateTime.parse(json['checkInTime'] as String),
  checkOutTime: json['checkOutTime'] == null
      ? null
      : DateTime.parse(json['checkOutTime'] as String),
  photoPath: json['photoPath'] as String?,
  syncStatus: json['syncStatus'] as String? ?? 'pending',
);

Map<String, dynamic> _$$AttendanceModelImplToJson(
  _$AttendanceModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'checkInTime': instance.checkInTime.toIso8601String(),
  'checkOutTime': instance.checkOutTime?.toIso8601String(),
  'photoPath': instance.photoPath,
  'syncStatus': instance.syncStatus,
};
