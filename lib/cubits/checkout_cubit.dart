import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/pos_repository.dart';
import '../data/datasource/local/local_cache_store.dart';
import '../data/models/sale_request_mapper.dart';
import '../data/constants/offline_sync_constants.dart';
import 'package:uuid/uuid.dart';
import 'cart_state.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final IPosRepository _repository;
  final LocalCacheStore _cache;
  final Uuid _uuid = const Uuid();

  CheckoutCubit(this._repository, this._cache) : super(const CheckoutState());

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

  Future<void> processCheckout(
    CartState cartState, {
    required bool isOnline,
  }) async {
    if (state.isProcessing) return;

    emit(
      state.copyWith(
        isProcessing: true,
        error: null,
        success: false,
        savedOffline: false,
      ),
    );

    try {
      final methods = await _repository.getPaymentMethods();
      final method = methods.firstWhere(
        (m) => m.name == state.selectedMethod,
        orElse: () => methods.first,
      );

      if (!isOnline) {
        await _saveOfflineCheckout(
          cartState,
          paymentMethodId: method.paymentMethodId,
        );
        return;
      }

      final request = SaleRequestMapper.fromCart(
        cartState: cartState,
        checkoutState: state,
        paymentMethodId: method.paymentMethodId,
      );

      final invoiceNumber = await _repository.createSale(request);
      emit(
        state.copyWith(
          isProcessing: false,
          success: true,
          savedOffline: false,
          invoiceNumber: invoiceNumber,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isProcessing: false, error: e.toString()));
    }
  }

  Future<void> _saveOfflineCheckout(
    CartState cartState, {
    required int paymentMethodId,
  }) async {
    try {
      final request = SaleRequestMapper.fromCart(
        cartState: cartState,
        checkoutState: state,
        paymentMethodId: paymentMethodId,
      ).copyWith(source: 'offline');

      final now = DateTime.now();
      final soldAt = now.toUtc().toIso8601String();
      final offlineId = _uuid.v4();
      final localInvoice =
          'INV-${now.year.toString().padLeft(4, '0')}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch % 10000}';

      final transaction = request.toJson()
        ..['offline_id'] = offlineId
        ..['sold_at'] = soldAt
        ..['source'] = 'offline';

      final queue = List<Map<String, dynamic>>.of(
        await _cache.readList(offlineSalesQueueKey),
      );
      queue.add({
        'invoice_number': localInvoice,
        'offline_id': offlineId,
        'created_at': now.toIso8601String(),
        'sold_at': soldAt,
        'status': 'pending',
        'payment_method': state.selectedMethod,
        'total': cartState.total,
        'transaction': transaction,
      });
      await _cache.saveList(offlineSalesQueueKey, queue);

      emit(
        state.copyWith(
          isProcessing: false,
          success: true,
          savedOffline: true,
          invoiceNumber: localInvoice,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isProcessing: false,
          error: 'Gagal menyimpan transaksi offline: $e',
        ),
      );
    }
  }

  void reset() {
    emit(const CheckoutState());
  }
}
