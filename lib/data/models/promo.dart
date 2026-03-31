// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo.freezed.dart';
part 'promo.g.dart';

@freezed
class Promo with _$Promo {
  const factory Promo({
    required int ID,
    required String name,
    @JsonKey(name: 'promo_type') required String promoType,
    @JsonKey(name: 'applies_to') required String appliesTo,
    required String condition,
    @JsonKey(name: 'min_qty') required int minQty,
    @JsonKey(name: 'min_total') required double minTotal,
    @JsonKey(name: 'discount_pct') required double discountPct,
    @JsonKey(name: 'max_discount') required double maxDiscount,
    @JsonKey(name: 'cut_price') required double cutPrice,
    @JsonKey(name: 'voucher_type') String? voucherType,
    @JsonKey(name: 'voucher_code') String? voucherCode,
    String? status,
  }) = _Promo;

  factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);
}
