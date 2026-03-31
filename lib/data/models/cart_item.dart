import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';
import 'variant.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required Product product,
    @Default(1) int quantity,
    @Default([]) List<VariantOption> selectedOptions,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

extension CartItemX on CartItem {
  double get subtotal {
    double basePrice = product.price;
    double additionalPrice = 0;
    for (var option in selectedOptions) {
      additionalPrice += option.additionalPrice;
    }
    return (basePrice + additionalPrice) * quantity;
  }
}
