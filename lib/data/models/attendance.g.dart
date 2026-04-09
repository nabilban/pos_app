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
  photoIn: json['photo_in'] as String?,
  photoOut: json['photo_out'] as String?,
  checkIn: json['check_in'] as String?,
  checkOut: json['check_out'] as String?,
  syncStatus: json['syncStatus'] as String? ?? 'pending',
);

Map<String, dynamic> _$$AttendanceModelImplToJson(
  _$AttendanceModelImpl instance,
) => <String, dynamic>{
  'ID': instance.id,
  'user_id': instance.userId,
  'photo_in': instance.photoIn,
  'photo_out': instance.photoOut,
  'check_in': instance.checkIn,
  'check_out': instance.checkOut,
  'syncStatus': instance.syncStatus,
};
