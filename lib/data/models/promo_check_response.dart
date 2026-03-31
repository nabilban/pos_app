// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo_check_response.freezed.dart';
part 'promo_check_response.g.dart';

@freezed
class PromoCheckResponse with _$PromoCheckResponse {
  const factory PromoCheckResponse({
    @JsonKey(name: 'promo_id') required int promoId,
    required String name,
    @JsonKey(name: 'promo_type') required String promoType,
    @JsonKey(name: 'discount_amount') required double discountAmount,
    required String description,
  }) = _PromoCheckResponse;

  factory PromoCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$PromoCheckResponseFromJson(json);
}
