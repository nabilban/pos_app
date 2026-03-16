// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutletImpl _$$OutletImplFromJson(Map<String, dynamic> json) => _$OutletImpl(
  id: (json['ID'] as num).toInt(),
  createdAt: json['CreatedAt'] as String,
  updatedAt: json['UpdatedAt'] as String,
  deletedAt: json['DeletedAt'] as String?,
  name: json['name'] as String,
  address: json['address'] as String,
  phone: json['phone'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$$OutletImplToJson(_$OutletImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'DeletedAt': instance.deletedAt,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'status': instance.status,
    };
