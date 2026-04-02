import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../data/repositories/sales_repository.dart';
import '../data/models/sale.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final ISalesRepository _salesRepository;

  HistoryCubit(this._salesRepository)
      : super(HistoryState(selectedDate: DateTime.now())) {
    loadSales();
  }

  Future<void> loadSales() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final sales = await _salesRepository.getSales();
      emit(state.copyWith(sales: sales, isLoading: false));
    } catch (e) {
      final message = e is DioException ? (e.message ?? e.toString()) : e.toString();
      emit(state.copyWith(isLoading: false, error: message));
    }
  }

  void setSearch(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setDate(DateTime? date) {
    emit(state.copyWith(selectedDate: date));
  }

  void setPaymentMethod(String method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }

  /// Returns the list of sales filtered by current search, date, and payment method criteria.
  List<Sale> get filteredSales {
    var sales = state.sales;

    // Filter by date
    if (state.selectedDate != null) {
      final d = state.selectedDate!;
      sales = sales.where((s) {
        final created = DateTime.tryParse(s.createdAt);
        if (created == null) return false;
        return created.year == d.year &&
            created.month == d.month &&
            created.day == d.day;
      }).toList();
    }

    // Filter by payment method
    if (state.selectedPaymentMethod != 'Semua Metode') {
      sales = sales
          .where(
              (s) => s.paymentMethod?.name == state.selectedPaymentMethod)
          .toList();
    }

    // Filter by search query
    if (state.searchQuery.isNotEmpty) {
      final q = state.searchQuery.toLowerCase();
      sales = sales.where((s) {
        if (s.invoiceNumber.toLowerCase().contains(q)) return true;
        if (s.customerName.toLowerCase().contains(q)) return true;
        if (s.items.any(
            (item) => item.product?.name.toLowerCase().contains(q) ?? false)) {
          return true;
        }
        return false;
      }).toList();
    }

    return sales;
  }

  /// Total transactions count for the current filter
  int get totalTransaksi => filteredSales.length;

  /// Total revenue for the current filter
  double get totalOmzet =>
      filteredSales.fold(0.0, (sum, s) => sum + s.grandTotal);

  /// Unique payment method names extracted from the loaded sales data
  List<String> get paymentMethods {
    final methods = state.sales
        .where((s) => s.paymentMethod != null)
        .map((s) => s.paymentMethod!.name)
        .toSet()
        .toList();
    methods.sort();
    return ['Semua Metode', ...methods];
  }
}
