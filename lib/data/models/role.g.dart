// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleImpl _$$RoleImplFromJson(Map<String, dynamic> json) => _$RoleImpl(
  id: (json['ID'] as num).toInt(),
  createdAt: json['CreatedAt'] as String,
  updatedAt: json['UpdatedAt'] as String,
  deletedAt: json['DeletedAt'] as String?,
  name: json['name'] as String,
  permissions: json['permissions'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$RoleImplToJson(_$RoleImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'DeletedAt': instance.deletedAt,
      'name': instance.name,
      'permissions': instance.permissions,
    };
