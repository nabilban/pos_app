// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleRequestImpl _$$SaleRequestImplFromJson(Map<String, dynamic> json) =>
    _$SaleRequestImpl(
      paymentMethodId: (json['payment_method_id'] as num).toInt(),
      customerName: json['customer_name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SaleItemRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceCategoryId: (json['price_category_id'] as num?)?.toInt(),
      promoId: (json['promo_id'] as num?)?.toInt(),
      source: json['source'] as String? ?? 'pos',
      manualDiscount: (json['manual_discount'] as num?)?.toDouble() ?? 0,
      additionalFee: (json['additional_fee'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$SaleRequestImplToJson(_$SaleRequestImpl instance) =>
    <String, dynamic>{
      'payment_method_id': instance.paymentMethodId,
      'customer_name': instance.customerName,
      'items': instance.items,
      'price_category_id': instance.priceCategoryId,
      'promo_id': instance.promoId,
      'source': instance.source,
      'manual_discount': instance.manualDiscount,
      'additional_fee': instance.additionalFee,
    };

_$SaleItemRequestImpl _$$SaleItemRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SaleItemRequestImpl(
  productId: (json['product_id'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  discount: (json['discount'] as num?)?.toDouble() ?? 0,
  variants: (json['variants'] as List<dynamic>)
      .map((e) => SaleVariantRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SaleItemRequestImplToJson(
  _$SaleItemRequestImpl instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'quantity': instance.quantity,
  'discount': instance.discount,
  'variants': instance.variants,
};

_$SaleVariantRequestImpl _$$SaleVariantRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SaleVariantRequestImpl(
  variantOptionId: (json['variant_option_id'] as num).toInt(),
);

Map<String, dynamic> _$$SaleVariantRequestImplToJson(
  _$SaleVariantRequestImpl instance,
) => <String, dynamic>{'variant_option_id': instance.variantOptionId};
