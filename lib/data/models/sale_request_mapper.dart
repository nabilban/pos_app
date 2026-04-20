import '../../cubits/cart_state.dart';
import '../../cubits/checkout_state.dart';
import 'sale_request.dart';

extension SaleRequestMapper on SaleRequest {
  static SaleRequest fromCart({
    required CartState cartState,
    required CheckoutState checkoutState,
    required int paymentMethodId,
  }) {
    return SaleRequest(
      paymentMethodId: paymentMethodId,
      customerName: checkoutState.buyerName.trim().isEmpty ? 'Guest' : checkoutState.buyerName.trim(),
      priceCategoryId: checkoutState.selectedPriceCategoryId,
      promoId: cartState.appliedPromo?.promoId,
      source: 'pos',
      additionalFee: 0,
      items: cartState.items.map((item) {
        return SaleItemRequest(
          productId: item.product.id,
          quantity: item.quantity,
          variants: item.selectedOptions
              .map((opt) => SaleVariantRequest(variantOptionId: opt.id))
              .toList(),
          discount: 0,
        );
      }).toList(),
      manualDiscount: cartState.discount,
    );
  }
}
