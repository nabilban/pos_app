import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/sale_request_mapper.dart';
import 'cart_state.dart';
import 'checkout_state.dart';

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

  void setPriceCategoryId(int? id) {
    emit(state.copyWith(selectedPriceCategoryId: id));
  }

  Future<void> processCheckout(CartState cartState) async {
    if (state.isProcessing) return;

    emit(state.copyWith(isProcessing: true, error: null, success: false));

    try {
      final methods = await _repository.getPaymentMethods();
      final method = methods.firstWhere(
        (m) => m.name == state.selectedMethod,
        orElse: () => methods.first,
      );

      final request = SaleRequestMapper.fromCart(
        cartState: cartState,
        checkoutState: state,
        paymentMethodId: method.paymentMethodId,
      );

      final invoiceNumber = await _repository.createSale(request);
      emit(state.copyWith(isProcessing: false, success: true, invoiceNumber: invoiceNumber));
    } catch (e) {
      emit(state.copyWith(isProcessing: false, error: e.toString()));
    }
  }

  void reset() {
    emit(const CheckoutState());
  }
}
