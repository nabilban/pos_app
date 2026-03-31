import '../models/product.dart';
import '../models/category.dart';
import '../models/brand.dart';
import '../models/payment_method.dart';
import '../models/promo.dart';
import '../models/promo_check_response.dart';
import '../models/cart_item.dart';
import '../datasource/remote/api_client.dart';

abstract class IPosRepository {
  Future<List<Product>> getProducts();
  Future<List<Category>> getCategories();
  Future<List<Brand>> getBrands();
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<List<Promo>> getPromos();
  Future<PromoCheckResponse> checkVoucher(String code, List<CartItem> items);
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

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      final response = await _apiClient.authenticatedDio.get(
        '/payment-methods',
      );
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => PaymentMethod.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Promo>> getPromos() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/promos');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Promo.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PromoCheckResponse> checkVoucher(
    String code,
    List<CartItem> items,
  ) async {
    try {
      final response = await _apiClient.authenticatedDio.post(
        '/promos/check-voucher',
        data: {
          'code': code,
          'items': items
              .map(
                (item) => {
                  'product_id': item.product.id,
                  'category_id': item.product.categoryId,
                  'brand_id': item.product.brandId,
                  'quantity': item.quantity,
                  'price': item.subtotal / item.quantity,
                },
              )
              .toList(),
          "subtotal": items
              .map((item) => item.subtotal)
              .reduce((a, b) => a + b),
        },
      );
      return PromoCheckResponse.fromJson(response.data['data']);
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
