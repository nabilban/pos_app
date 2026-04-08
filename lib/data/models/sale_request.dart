// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_request.freezed.dart';
part 'sale_request.g.dart';

@freezed
class SaleRequest with _$SaleRequest {
  @JsonSerializable(explicitToJson: true)
  const factory SaleRequest({
    @JsonKey(name: 'payment_method_id') required int paymentMethodId,
    @JsonKey(name: 'customer_name') required String customerName,
    required List<SaleItemRequest> items,
    @JsonKey(name: 'price_category_id') int? priceCategoryId,
    @JsonKey(name: 'promo_id') int? promoId,
    @Default('pos') String source,
    @JsonKey(name: 'manual_discount') @Default(0) double manualDiscount,
    @JsonKey(name: 'additional_fee') @Default(0) double additionalFee,
  }) = _SaleRequest;

  factory SaleRequest.fromJson(Map<String, dynamic> json) =>
      _$SaleRequestFromJson(json);
}

@freezed
class SaleItemRequest with _$SaleItemRequest {
  @JsonSerializable(explicitToJson: true)
  const factory SaleItemRequest({
    @JsonKey(name: 'product_id') required int productId,
    required int quantity,
    @Default(0) double discount,
    required List<SaleVariantRequest> variants,
  }) = _SaleItemRequest;

  factory SaleItemRequest.fromJson(Map<String, dynamic> json) =>
      _$SaleItemRequestFromJson(json);
}

@freezed
class SaleVariantRequest with _$SaleVariantRequest {
  @JsonSerializable(explicitToJson: true)
  const factory SaleVariantRequest({
    @JsonKey(name: 'variant_option_id') required int variantOptionId,
  }) = _SaleVariantRequest;

  factory SaleVariantRequest.fromJson(Map<String, dynamic> json) =>
      _$SaleVariantRequestFromJson(json);
}
