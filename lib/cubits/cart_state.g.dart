// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartStateImpl _$$CartStateImplFromJson(Map<String, dynamic> json) =>
    _$CartStateImpl(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      appliedPromo: json['appliedPromo'] == null
          ? null
          : PromoCheckResponse.fromJson(
              json['appliedPromo'] as Map<String, dynamic>,
            ),
      priceOverrides:
          (json['priceOverrides'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$CartStateImplToJson(_$CartStateImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'appliedPromo': instance.appliedPromo,
      'priceOverrides': instance.priceOverrides.map(
        (k, e) => MapEntry(k.toString(), e),
      ),
    };
