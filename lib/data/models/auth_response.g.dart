// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      message: json['message'] as String,
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'user': instance.user,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: (json['ID'] as num).toInt(),
  createdAt: json['CreatedAt'] as String,
  updatedAt: json['UpdatedAt'] as String,
  deletedAt: json['DeletedAt'] as String?,
  name: json['name'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  roleId: (json['role_id'] as num).toInt(),
  outletId: (json['outlet_id'] as num?)?.toInt(),
  canAccessCenter: json['can_access_center'] as bool,
  role: Role.fromJson(json['role'] as Map<String, dynamic>),
  outlet: json['outlet'] == null
      ? null
      : Outlet.fromJson(json['outlet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'DeletedAt': instance.deletedAt,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'role_id': instance.roleId,
      'outlet_id': instance.outletId,
      'can_access_center': instance.canAccessCenter,
      'role': instance.role,
      'outlet': instance.outlet,
    };
