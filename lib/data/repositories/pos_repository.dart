import '../models/product.dart';
import '../models/category.dart';
import '../models/brand.dart';
import '../models/payment_method.dart';
import '../models/promo.dart';
import '../models/promo_check_response.dart';
import '../models/cart_item.dart';
import '../models/sale_request.dart';
import '../models/price_category.dart';
import '../models/price_category_product.dart';
import '../datasource/remote/api_client.dart';
import '../datasource/local/local_cache_store.dart';

abstract class IPosRepository {
  Future<List<Product>> getProducts();
  Future<List<Category>> getCategories();
  Future<List<Brand>> getBrands();
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<List<Promo>> getPromos();
  Future<PromoCheckResponse> checkVoucher(String code, List<CartItem> items);
  Future<String> createSale(SaleRequest request);
  Future<List<PriceCategory>> getPriceCategories();
  Future<List<PriceCategoryProduct>> getPriceCategoryProducts(int categoryId);
}

class PosRepository implements IPosRepository {
  final ApiClient _apiClient;
  final LocalCacheStore _cache;

  static const _productsKey = 'pos_products';
  static const _categoriesKey = 'pos_categories';
  static const _brandsKey = 'pos_brands';
  static const _paymentMethodsKey = 'pos_payment_methods';
  static const _promosKey = 'pos_promos';
  static const _priceCategoriesKey = 'pos_price_categories';

  String _priceCategoryProductsKey(int categoryId) =>
      'pos_price_category_products_$categoryId';

  PosRepository(this._apiClient, this._cache);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/products');
      final List<dynamic> data = response.data['data'] ?? [];
      final products = data
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _productsKey,
        products.map((e) => e.toJson()).toList(growable: false),
      );
      return products;
    } catch (_) {
      final cached = await _cache.readList(_productsKey);
      if (cached.isNotEmpty) {
        return cached.map(Product.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/categories');
      final List<dynamic> data = response.data['data'] ?? [];
      final categories = data
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _categoriesKey,
        categories.map((e) => e.toJson()).toList(growable: false),
      );
      return categories;
    } catch (_) {
      final cached = await _cache.readList(_categoriesKey);
      if (cached.isNotEmpty) {
        return cached.map(Category.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }

  @override
  Future<List<Brand>> getBrands() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/brands');
      final List<dynamic> data = response.data['data'] ?? [];
      final brands = data
          .map((json) => Brand.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _brandsKey,
        brands.map((e) => e.toJson()).toList(growable: false),
      );
      return brands;
    } catch (_) {
      final cached = await _cache.readList(_brandsKey);
      if (cached.isNotEmpty) {
        return cached.map(Brand.fromJson).toList(growable: false);
      }
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
      final paymentMethods = data
          .map((json) => PaymentMethod.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _paymentMethodsKey,
        paymentMethods.map((e) => e.toJson()).toList(growable: false),
      );
      return paymentMethods;
    } catch (_) {
      final cached = await _cache.readList(_paymentMethodsKey);
      if (cached.isNotEmpty) {
        return cached.map(PaymentMethod.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }

  @override
  Future<List<Promo>> getPromos() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/promos');
      final List<dynamic> data = response.data['data'] ?? [];
      final promos = data
          .map((json) => Promo.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _promosKey,
        promos.map((e) => e.toJson()).toList(growable: false),
      );
      return promos;
    } catch (_) {
      final cached = await _cache.readList(_promosKey);
      if (cached.isNotEmpty) {
        return cached.map(Promo.fromJson).toList(growable: false);
      }
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

  @override
  Future<String> createSale(SaleRequest request) async {
    try {
      final response = await _apiClient.authenticatedDio.post(
        '/sales',
        data: request.toJson(),
      );

      final data = response.data;
      if (data != null && data['data'] != null) {
        return data['data']['invoice_number']?.toString() ?? 'SUCCESS';
      }
      return 'SUCCESS';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PriceCategory>> getPriceCategories() async {
    try {
      final response = await _apiClient.authenticatedDio.get(
        '/price-categories',
      );
      final List<dynamic> data = response.data['data'] ?? [];
      final categories = data
          .map((json) => PriceCategory.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _priceCategoriesKey,
        categories.map((e) => e.toJson()).toList(growable: false),
      );
      return categories;
    } catch (_) {
      final cached = await _cache.readList(_priceCategoriesKey);
      if (cached.isNotEmpty) {
        return cached.map(PriceCategory.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }

  @override
  Future<List<PriceCategoryProduct>> getPriceCategoryProducts(
    int categoryId,
  ) async {
    try {
      final response = await _apiClient.authenticatedDio.get(
        '/price-categories/$categoryId/products',
      );
      final List<dynamic> data = response.data['data'] ?? [];
      final products = data
          .map(
            (json) =>
                PriceCategoryProduct.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      await _cache.saveList(
        _priceCategoryProductsKey(categoryId),
        products.map((e) => e.toJson()).toList(growable: false),
      );
      return products;
    } catch (_) {
      final cached = await _cache.readList(
        _priceCategoryProductsKey(categoryId),
      );
      if (cached.isNotEmpty) {
        return cached
            .map(PriceCategoryProduct.fromJson)
            .toList(growable: false);
      }
      rethrow;
    }
  }
}
