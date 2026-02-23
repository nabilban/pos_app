import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/cart_item.dart';

part 'cart_state.freezed.dart';
part 'cart_state.g.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({@Default([]) List<CartItem> items}) = _CartState;

  const CartState._();

  double get total => items.fold(0, (sum, item) => sum + item.subtotal);
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  factory CartState.fromJson(Map<String, dynamic> json) =>
      _$CartStateFromJson(json);
}
