// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantImpl _$$VariantImplFromJson(Map<String, dynamic> json) =>
    _$VariantImpl(
      id: (json['ID'] as num).toInt(),
      createdAt: json['CreatedAt'] as String,
      updatedAt: json['UpdatedAt'] as String,
      deletedAt: json['DeletedAt'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      minSelect: (json['min_select'] as num).toInt(),
      maxSelect: (json['max_select'] as num).toInt(),
      status: json['status'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => VariantOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VariantImplToJson(_$VariantImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'DeletedAt': instance.deletedAt,
      'name': instance.name,
      'description': instance.description,
      'min_select': instance.minSelect,
      'max_select': instance.maxSelect,
      'status': instance.status,
      'options': instance.options,
    };

_$VariantOptionImpl _$$VariantOptionImplFromJson(Map<String, dynamic> json) =>
    _$VariantOptionImpl(
      id: (json['ID'] as num).toInt(),
      createdAt: json['CreatedAt'] as String,
      updatedAt: json['UpdatedAt'] as String,
      deletedAt: json['DeletedAt'] as String?,
      variantCategoryId: (json['variant_category_id'] as num).toInt(),
      name: json['name'] as String,
      additionalPrice: (json['additional_price'] as num).toDouble(),
    );

Map<String, dynamic> _$$VariantOptionImplToJson(_$VariantOptionImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'DeletedAt': instance.deletedAt,
      'variant_category_id': instance.variantCategoryId,
      'name': instance.name,
      'additional_price': instance.additionalPrice,
    };
