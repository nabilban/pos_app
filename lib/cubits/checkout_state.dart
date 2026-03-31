import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(0) int currentStep, // 0: Confirmation, 1: Payment
    @Default('Tunai') String selectedMethod,
    @Default('') String buyerName,
    @Default(0.0) double cashAmount,
    @Default(false) bool isProcessing,
    @Default(false) bool success,
    String? error,
  }) = _CheckoutState;
}
