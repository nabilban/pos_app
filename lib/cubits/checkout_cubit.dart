import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/sale_request.dart';
import 'cart_state.dart';
import 'checkout_state.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

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
        customerName: state.buyerName.trim().isEmpty ? 'Guest' : state.buyerName.trim(),
        priceCategoryId: state.selectedPriceCategoryId, // Explicitly pass from state (can be null)
        promoId: cartState.appliedPromo?.promoId, // Explicitly pass (can be null)
        source: 'pos', // Always 'pos' as per example
        additionalFee: 0, // Always 0 as per example
        items: cartState.items.map((item) {
          final List<SaleVariantRequest> flattenedVariants = [];
          // Repeat variants for each unit of quantity as required by API
          for (int i = 0; i < item.quantity; i++) {
            flattenedVariants.addAll(
              item.selectedOptions.map((opt) => SaleVariantRequest(
                variantOptionId: opt.id,
              )),
            );
          }

          return SaleItemRequest(
            productId: item.product.id,
            quantity: item.quantity,
            variants: flattenedVariants,
            discount: 0, // Explicitly 0 for each item as per example
          );
        }).toList(),
        manualDiscount: cartState.discount,
      );

      // Log the request body for debugging as requested by the user
      print('DEBUG - SaleRequest Body (JSON): ${jsonEncode(request.toJson())}');
      final invoiceNumber = await _repository.createSale(request);
      emit(state.copyWith(isProcessing: false, success: true, invoiceNumber: invoiceNumber));
    } catch (e) {
      String message = 'Gagal memproses transaksi: $e';
      if (e is DioException) {
        final response = e.response;
        if (response != null) {
          final data = response.data;
          message = 'Server Error (${response.statusCode}): ${data is Map ? (data['message'] ?? data.toString()) : data.toString()}';
          print('DEBUG - Server Error Response: $data');
        }
      }
      print('DEBUG - Final Error Message: $message');
      emit(state.copyWith(isProcessing: false, error: message));
    }
  }

  void reset() {
    emit(const CheckoutState());
  }
}
