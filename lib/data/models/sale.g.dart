// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleImpl _$$SaleImplFromJson(Map<String, dynamic> json) => _$SaleImpl(
  id: (json['ID'] as num).toInt(),
  createdAt: json['CreatedAt'] as String,
  invoiceNumber: json['invoice_number'] as String,
  customerName: json['customer_name'] as String? ?? '',
  paymentMethodId: (json['payment_method_id'] as num).toInt(),
  subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
  discountTotal: (json['discount_total'] as num?)?.toDouble() ?? 0,
  manualDiscount: (json['manual_discount'] as num?)?.toDouble() ?? 0,
  additionalFee: (json['additional_fee'] as num?)?.toDouble() ?? 0,
  grandTotal: (json['grand_total'] as num?)?.toDouble() ?? 0,
  source: json['source'] as String? ?? 'pos',
  user: json['user'] == null
      ? null
      : SaleUser.fromJson(json['user'] as Map<String, dynamic>),
  paymentMethod: json['payment_method'] == null
      ? null
      : PaymentMethod.fromJson(json['payment_method'] as Map<String, dynamic>),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => SaleItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$SaleImplToJson(_$SaleImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
      'invoice_number': instance.invoiceNumber,
      'customer_name': instance.customerName,
      'payment_method_id': instance.paymentMethodId,
      'subtotal': instance.subtotal,
      'discount_total': instance.discountTotal,
      'manual_discount': instance.manualDiscount,
      'additional_fee': instance.additionalFee,
      'grand_total': instance.grandTotal,
      'source': instance.source,
      'user': instance.user,
      'payment_method': instance.paymentMethod,
      'items': instance.items,
    };

_$SaleUserImpl _$$SaleUserImplFromJson(Map<String, dynamic> json) =>
    _$SaleUserImpl(
      id: (json['ID'] as num).toInt(),
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );

Map<String, dynamic> _$$SaleUserImplToJson(_$SaleUserImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'name': instance.name,
      'username': instance.username,
    };

_$SaleItemImpl _$$SaleItemImplFromJson(Map<String, dynamic> json) =>
    _$SaleItemImpl(
      id: (json['ID'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      basePrice: (json['base_price'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
      product: json['product'] == null
          ? null
          : SaleProduct.fromJson(json['product'] as Map<String, dynamic>),
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((e) => SaleItemVariant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SaleItemImplToJson(_$SaleItemImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'base_price': instance.basePrice,
      'discount': instance.discount,
      'subtotal': instance.subtotal,
      'product': instance.product,
      'variants': instance.variants,
    };

_$SaleProductImpl _$$SaleProductImplFromJson(Map<String, dynamic> json) =>
    _$SaleProductImpl(
      id: (json['ID'] as num).toInt(),
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$SaleProductImplToJson(_$SaleProductImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'name': instance.name,
      'price': instance.price,
    };

_$SaleItemVariantImpl _$$SaleItemVariantImplFromJson(
  Map<String, dynamic> json,
) => _$SaleItemVariantImpl(
  id: (json['ID'] as num).toInt(),
  additionalPrice: (json['additional_price'] as num?)?.toDouble() ?? 0,
  variantOption: json['variant_option'] == null
      ? null
      : SaleVariantOption.fromJson(
          json['variant_option'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$SaleItemVariantImplToJson(
  _$SaleItemVariantImpl instance,
) => <String, dynamic>{
  'ID': instance.id,
  'additional_price': instance.additionalPrice,
  'variant_option': instance.variantOption,
};

_$SaleVariantOptionImpl _$$SaleVariantOptionImplFromJson(
  Map<String, dynamic> json,
) => _$SaleVariantOptionImpl(
  id: (json['ID'] as num).toInt(),
  name: json['name'] as String? ?? '',
  additionalPrice: (json['additional_price'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$$SaleVariantOptionImplToJson(
  _$SaleVariantOptionImpl instance,
) => <String, dynamic>{
  'ID': instance.id,
  'name': instance.name,
  'additional_price': instance.additionalPrice,
};
