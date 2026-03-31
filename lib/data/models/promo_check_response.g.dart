// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromoCheckResponseImpl _$$PromoCheckResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PromoCheckResponseImpl(
  promoId: (json['promo_id'] as num).toInt(),
  name: json['name'] as String,
  promoType: json['promo_type'] as String,
  discountAmount: (json['discount_amount'] as num).toDouble(),
  description: json['description'] as String,
);

Map<String, dynamic> _$$PromoCheckResponseImplToJson(
  _$PromoCheckResponseImpl instance,
) => <String, dynamic>{
  'promo_id': instance.promoId,
  'name': instance.name,
  'promo_type': instance.promoType,
  'discount_amount': instance.discountAmount,
  'description': instance.description,
};
