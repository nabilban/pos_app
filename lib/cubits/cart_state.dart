import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/cart_item.dart';
import '../data/models/promo_check_response.dart';

part 'cart_state.freezed.dart';
part 'cart_state.g.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItem> items,
    PromoCheckResponse? appliedPromo,
  }) = _CartState;

  factory CartState.fromJson(Map<String, dynamic> json) =>
      _$CartStateFromJson(json);
}

extension CartStateX on CartState {
  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);
  double get discount => appliedPromo?.discountAmount ?? 0;
  double get total => subtotal - discount;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
