// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_category.freezed.dart';
part 'price_category.g.dart';

@freezed
class PriceCategory with _$PriceCategory {
  const factory PriceCategory({
    @JsonKey(name: 'ID') required int id,
    required String name,
  }) = _PriceCategory;

  factory PriceCategory.fromJson(Map<String, dynamic> json) =>
      _$PriceCategoryFromJson(json);
}
