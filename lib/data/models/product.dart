// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';
import 'brand.dart';
import 'unit.dart';
import 'variant.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'UpdatedAt') required String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    required String code,
    required String name,
    required String description,
    required double price,
    required int stock,
    String? image,
    @Default("active") String status,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'brand_id') int? brandId,
    @JsonKey(name: 'unit_id') int? unitId,
    required Category? category,
    required Brand? brand,
    required Unit? unit,
    @Default([]) List<Variant> variants,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
