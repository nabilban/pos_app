import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/pos_repository.dart';
import '../data/datasource/local/local_cache_store.dart';
import '../data/models/sale_request_mapper.dart';
import '../data/models/payment_method.dart';
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
      List<PaymentMethod> methods = const <PaymentMethod>[];
      try {
        methods = await _repository.getPaymentMethods();
      } catch (_) {
        if (isOnline) rethrow;
      }

      if (!isOnline) {
        final cashMethod = _findCashMethod(methods);
        final cashMethodName = cashMethod?.name ?? 'Cash';
        final cashMethodId = cashMethod?.paymentMethodId ?? 0;

        if (state.selectedMethod != cashMethodName) {
          emit(state.copyWith(selectedMethod: cashMethodName, error: null));
        }

        await _saveOfflineCheckout(
          cartState,
          paymentMethodId: cashMethodId,
          paymentMethodName: cashMethodName,
        );
        return;
      }

      if (methods.isEmpty) {
        throw Exception('Metode pembayaran tidak tersedia.');
      }

      final method =
          _findMethodByName(methods, state.selectedMethod) ?? methods.first;

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
    required String paymentMethodName,
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
        'payment_method': paymentMethodName,
        'total': cartState.total,
        'transaction': transaction,
      });
      await _cache.saveList(offlineSalesQueueKey, queue);

      emit(
        state.copyWith(
          isProcessing: false,
          success: true,
          savedOffline: true,
          selectedMethod: paymentMethodName,
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

  PaymentMethod? _findMethodByName(
    List<PaymentMethod> methods,
    String methodName,
  ) {
    final selected = methodName.trim().toLowerCase();
    for (final method in methods) {
      if (method.name.trim().toLowerCase() == selected) {
        return method;
      }
    }
    return null;
  }

  PaymentMethod? _findCashMethod(List<PaymentMethod> methods) {
    for (final method in methods) {
      final normalized = method.name.trim().toLowerCase();
      if (normalized == 'cash' || normalized == 'tunai') {
        return method;
      }
    }
    return null;
  }
}
