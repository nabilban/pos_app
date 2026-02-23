import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default('') String selectedPaymentMethod,
    @Default(0.0) double cashAmount,
  }) = _CheckoutState;
}
