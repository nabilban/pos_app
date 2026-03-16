// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variant.freezed.dart';
part 'variant.g.dart';

@freezed
class Variant with _$Variant {
  const factory Variant({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'UpdatedAt') required String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    required String name,
    String? description,
    @JsonKey(name: 'min_select') required int minSelect,
    @JsonKey(name: 'max_select') required int maxSelect,
    required String status,
    required List<VariantOption> options,
  }) = _Variant;

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}

@freezed
class VariantOption with _$VariantOption {
  const factory VariantOption({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'UpdatedAt') required String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    @JsonKey(name: 'variant_category_id') required int variantCategoryId,
    required String name,
    @JsonKey(name: 'additional_price') required double additionalPrice,
  }) = _VariantOption;

  factory VariantOption.fromJson(Map<String, dynamic> json) =>
      _$VariantOptionFromJson(json);
}
