// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_category_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceCategoryProductImpl _$$PriceCategoryProductImplFromJson(
  Map<String, dynamic> json,
) => _$PriceCategoryProductImpl(
  id: (json['ID'] as num).toInt(),
  productId: (json['product_id'] as num).toInt(),
  priceCategoryId: (json['price_category_id'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  product: json['product'] == null
      ? null
      : Product.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PriceCategoryProductImplToJson(
  _$PriceCategoryProductImpl instance,
) => <String, dynamic>{
  'ID': instance.id,
  'product_id': instance.productId,
  'price_category_id': instance.priceCategoryId,
  'price': instance.price,
  'product': instance.product,
};
