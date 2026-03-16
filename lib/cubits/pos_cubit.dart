import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/pos_repository.dart';
import '../data/models/brand.dart';
import '../data/models/category.dart';
import '../data/models/product.dart';
import 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  final IPosRepository _repository;

  PosCubit(this._repository) : super(const PosState()) {
    loadData();
  }

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final products = await _repository.getProducts();
      final categories = await _repository.getCategories();
      final brands = await _repository.getBrands();
      emit(
        state.copyWith(
          products: products,
          categories: categories,
          brands: brands,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setCategory(Category? category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setBrand(Brand? brand) {
    emit(state.copyWith(selectedBrand: brand));
  }

  List<Product> get filteredProducts {
    return state.products.where((product) {
      // Search filter
      final matchesSearch = product.name
              .toLowerCase()
              .contains(state.searchQuery.toLowerCase()) ||
          product.code.toLowerCase().contains(state.searchQuery.toLowerCase());

      // Category filter
      final matchesCategory = state.selectedCategory == null ||
          product.categoryId == state.selectedCategory!.id;

      // Brand filter
      final matchesBrand = state.selectedBrand == null ||
          product.brandId == state.selectedBrand!.id;

      return matchesSearch && matchesCategory && matchesBrand;
    }).toList();
  }
}
