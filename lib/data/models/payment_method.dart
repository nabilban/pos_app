// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'outlet.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required int ID,
    required String name,
    @JsonKey(name: 'show_in_sale') required bool showInSale,
    @JsonKey(name: 'show_in_purchase') required bool showInPurchase,
    @JsonKey(name: 'outlet_id') int? outletId,
    Outlet? outlet,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}
