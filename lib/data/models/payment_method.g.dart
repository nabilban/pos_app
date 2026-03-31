// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentMethodImpl _$$PaymentMethodImplFromJson(Map<String, dynamic> json) =>
    _$PaymentMethodImpl(
      paymentMethodId: (json['ID'] as num).toInt(),
      name: json['name'] as String,
      showInSale: json['show_in_sale'] as bool,
      showInPurchase: json['show_in_purchase'] as bool,
      outletId: (json['outlet_id'] as num?)?.toInt(),
      outlet: json['outlet'] == null
          ? null
          : Outlet.fromJson(json['outlet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PaymentMethodImplToJson(_$PaymentMethodImpl instance) =>
    <String, dynamic>{
      'ID': instance.paymentMethodId,
      'name': instance.name,
      'show_in_sale': instance.showInSale,
      'show_in_purchase': instance.showInPurchase,
      'outlet_id': instance.outletId,
      'outlet': instance.outlet,
    };
