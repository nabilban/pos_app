// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromoImpl _$$PromoImplFromJson(Map<String, dynamic> json) => _$PromoImpl(
  ID: (json['ID'] as num).toInt(),
  name: json['name'] as String,
  promoType: json['promo_type'] as String,
  appliesTo: json['applies_to'] as String,
  condition: json['condition'] as String,
  minQty: (json['min_qty'] as num).toInt(),
  minTotal: (json['min_total'] as num).toDouble(),
  discountPct: (json['discount_pct'] as num).toDouble(),
  maxDiscount: (json['max_discount'] as num).toDouble(),
  cutPrice: (json['cut_price'] as num).toDouble(),
  voucherType: json['voucher_type'] as String?,
  voucherCode: json['voucher_code'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$PromoImplToJson(_$PromoImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'name': instance.name,
      'promo_type': instance.promoType,
      'applies_to': instance.appliesTo,
      'condition': instance.condition,
      'min_qty': instance.minQty,
      'min_total': instance.minTotal,
      'discount_pct': instance.discountPct,
      'max_discount': instance.maxDiscount,
      'cut_price': instance.cutPrice,
      'voucher_type': instance.voucherType,
      'voucher_code': instance.voucherCode,
      'status': instance.status,
    };
