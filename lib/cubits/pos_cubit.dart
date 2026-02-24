import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/pos_repository.dart';
import 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  final PosRepository _repository;

  PosCubit(this._repository) : super(const PosState()) {
    loadData();
  }

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final products = await _repository.getProducts();
      final categories = await _repository.getCategories();
      emit(
        state.copyWith(
          products: products,
          categories: categories,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void setCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
