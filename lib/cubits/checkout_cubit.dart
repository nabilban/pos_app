import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  void setPaymentMethod(String method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }

  void setCashAmount(double amount) {
    emit(state.copyWith(cashAmount: amount));
  }

  void reset() {
    emit(const CheckoutState());
  }
}
