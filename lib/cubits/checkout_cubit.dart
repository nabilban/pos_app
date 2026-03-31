import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/sale_request.dart';
import 'cart_state.dart';
import 'checkout_state.dart';
import 'package:dio/dio.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final IPosRepository _repository;

  CheckoutCubit(this._repository) : super(const CheckoutState());

  void setStep(int step) {
    emit(state.copyWith(currentStep: step, error: null));
  }

  void setBuyerName(String name) {
    emit(state.copyWith(buyerName: name));
  }

  void setPaymentMethod(String method) {
    emit(state.copyWith(selectedMethod: method, error: null));
  }

  void setCashAmount(double amount) {
    emit(state.copyWith(cashAmount: amount));
  }

  Future<void> processCheckout(CartState cartState) async {
    if (state.isProcessing) return;

    emit(state.copyWith(isProcessing: true, error: null, success: false));

    try {
      // Find selected payment method ID (Need to fetch list or match by name - matching logic here)
      // For now, mapping logic should be consistent with the repository structure.
      // We'll pass the method name to find the right ID from the repository client.
      
      final methods = await _repository.getPaymentMethods();
      final method = methods.firstWhere(
        (m) => m.name == state.selectedMethod,
        orElse: () => methods.first,
      );

      final request = SaleRequest(
        paymentMethodId: method.paymentMethodId,
        customerName: state.buyerName.trim(),
        priceCategoryId: null, // As requested previously
        promoId: cartState.appliedPromo?.promoId,
        items: cartState.items.map((item) => SaleItemRequest(
          productId: item.product.id,
          quantity: item.quantity,
          variants: item.selectedOptions.map((opt) => SaleVariantRequest(
            variantOptionId: opt.id,
          )).toList(),
        )).toList(),
        manualDiscount: cartState.discount,
      );

      final invoiceNumber = await _repository.createSale(request);
      emit(state.copyWith(isProcessing: false, success: true, invoiceNumber: invoiceNumber));
    } catch (e) {
      String message = 'Gagal memproses transaksi: $e';
      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map && data.containsKey('message')) {
          message = data['message'];
        }
      }
      emit(state.copyWith(isProcessing: false, error: message));
    }
  }

  void reset() {
    emit(const CheckoutState());
  }
}
