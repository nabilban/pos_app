import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/sale.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<Sale> sales,
    @Default(true) bool isLoading,
    @Default('') String error,
    @Default('') String searchQuery,
    DateTime? selectedDate,
    @Default('Semua Metode') String selectedPaymentMethod,
  }) = _HistoryState;
}
