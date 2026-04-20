import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../data/repositories/sales_repository.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/sale.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final ISalesRepository _salesRepository;
  final IPosRepository _posRepository;

  HistoryCubit(this._salesRepository, this._posRepository)
      : super(HistoryState(selectedDate: DateTime.now())) {
    loadSales();
  }

  Future<void> loadSales() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final sales = await _salesRepository.getSales();
      final masterPaymentMethods = await _posRepository.getPaymentMethods();
      
      // Use master list for dropdown, ensuring 'Semua Metode' is first
      final methods = masterPaymentMethods
          .map((m) => m.name.trim())
          .toSet()
          .toList();
      methods.sort();
      final allMethods = ['Semua Metode', ...methods];

      emit(state.copyWith(
        sales: sales, 
        paymentMethods: allMethods,
        isLoading: false,
      ));
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
      final selected = state.selectedPaymentMethod.toLowerCase().trim();
      sales = sales.where((s) {
        final methodName = s.paymentMethod?.name.toLowerCase().trim();
        return methodName == selected;
      }).toList();
    }

    // Filter by search query
    if (state.searchQuery.isNotEmpty) {
      final q = state.searchQuery.toLowerCase().trim();
      sales = sales.where((s) {
        if (s.invoiceNumber.toLowerCase().contains(q)) return true;
        if (s.customerName.toLowerCase().contains(q)) return true;
        if (s.items.any((item) =>
            item.product?.name.toLowerCase().contains(q) ?? false)) {
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
}
