import '../models/product.dart';
import '../models/category.dart';
import '../models/brand.dart';
import '../datasource/remote/api_client.dart';

abstract class IPosRepository {
  Future<List<Product>> getProducts();
  Future<List<Category>> getCategories();
  Future<List<Brand>> getBrands();
  // Future<StoreInfo> getStoreInfo();
}

class PosRepository implements IPosRepository {
  final ApiClient _apiClient;

  PosRepository(this._apiClient);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/products');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) {
        try {
          return Product.fromJson(json);
        } catch (e) {
          rethrow;
        }
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/categories');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) {
        try {
          return Category.fromJson(json);
        } catch (e) {
          rethrow;
        }
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Brand>> getBrands() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/brands');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Brand.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<StoreInfo> getStoreInfo() async {
  //   // Keep this as is for now or update if there's an API for it
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   return currentUser;
  // }
}
