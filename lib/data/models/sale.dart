// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_method.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'invoice_number') required String invoiceNumber,
    @JsonKey(name: 'customer_name') @Default('') String customerName,
    @JsonKey(name: 'payment_method_id') required int paymentMethodId,
    @Default(0) double subtotal,
    @JsonKey(name: 'discount_total') @Default(0) double discountTotal,
    @JsonKey(name: 'manual_discount') @Default(0) double manualDiscount,
    @JsonKey(name: 'additional_fee') @Default(0) double additionalFee,
    @JsonKey(name: 'grand_total') @Default(0) double grandTotal,
    @Default('pos') String source,
    SaleUser? user,
    @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
    @Default([]) List<SaleItem> items,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}

@freezed
class SaleUser with _$SaleUser {
  const factory SaleUser({
    @JsonKey(name: 'ID') required int id,
    @Default('') String name,
    @Default('') String username,
  }) = _SaleUser;

  factory SaleUser.fromJson(Map<String, dynamic> json) =>
      _$SaleUserFromJson(json);
}

@freezed
class SaleItem with _$SaleItem {
  const factory SaleItem({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'product_id') required int productId,
    @Default(1) int quantity,
    @JsonKey(name: 'base_price') @Default(0) double basePrice,
    @Default(0) double discount,
    @Default(0) double subtotal,
    SaleProduct? product,
    @Default([]) List<SaleItemVariant> variants,
  }) = _SaleItem;

  factory SaleItem.fromJson(Map<String, dynamic> json) =>
      _$SaleItemFromJson(json);
}

@freezed
class SaleProduct with _$SaleProduct {
  const factory SaleProduct({
    @JsonKey(name: 'ID') required int id,
    @Default('') String name,
    @Default(0) double price,
  }) = _SaleProduct;

  factory SaleProduct.fromJson(Map<String, dynamic> json) =>
      _$SaleProductFromJson(json);
}

@freezed
class SaleItemVariant with _$SaleItemVariant {
  const factory SaleItemVariant({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'additional_price') @Default(0) double additionalPrice,
    @JsonKey(name: 'variant_option') SaleVariantOption? variantOption,
  }) = _SaleItemVariant;

  factory SaleItemVariant.fromJson(Map<String, dynamic> json) =>
      _$SaleItemVariantFromJson(json);
}

@freezed
class SaleVariantOption with _$SaleVariantOption {
  const factory SaleVariantOption({
    @JsonKey(name: 'ID') required int id,
    @Default('') String name,
    @JsonKey(name: 'additional_price') @Default(0) double additionalPrice,
  }) = _SaleVariantOption;

  factory SaleVariantOption.fromJson(Map<String, dynamic> json) =>
      _$SaleVariantOptionFromJson(json);
}
