// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'price_category_product.freezed.dart';
part 'price_category_product.g.dart';

@freezed
class PriceCategoryProduct with _$PriceCategoryProduct {
  const factory PriceCategoryProduct({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'price_category_id') required int priceCategoryId,
    required double price,
    Product? product,
  }) = _PriceCategoryProduct;

  factory PriceCategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$PriceCategoryProductFromJson(json);
}
