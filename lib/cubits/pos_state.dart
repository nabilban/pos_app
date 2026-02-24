import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/product.dart';

part 'pos_state.freezed.dart';

@freezed
class PosState with _$PosState {
  const factory PosState({
    @Default('Semua') String selectedCategory,
    @Default([]) List<Product> products,
    @Default([]) List<String> categories,
    @Default(false) bool isLoading,
  }) = _PosState;
}
