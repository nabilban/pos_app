import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/product.dart';
import '../data/models/category.dart';
import '../data/models/brand.dart';
import '../data/models/payment_method.dart';

part 'pos_state.freezed.dart';

@freezed
class PosState with _$PosState {
  const factory PosState({
    Category? selectedCategory,
    Brand? selectedBrand,
    @Default('') String searchQuery,
    @Default([]) List<Product> products,
    @Default([]) List<Category> categories,
    @Default([]) List<Brand> brands,
    @Default([]) List<PaymentMethod> paymentMethods,
    @Default(false) bool isLoading,
  }) = _PosState;
}
