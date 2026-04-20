import 'package:dio/dio.dart';
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
import '../database/app_database.dart';
import 'package:drift/drift.dart';

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
  final AppDatabase _db;

  PosRepository(this._apiClient, this._db);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/products');
      final List<dynamic> data = response.data['data'] ?? [];
      final products = data
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
      
      await _db.saveProducts(products.map((p) => ProductsCompanion.insert(
        id: Value(p.id),
        createdAt: p.createdAt,
        updatedAt: p.updatedAt,
        deletedAt: Value(p.deletedAt),
        code: p.code,
        name: p.name,
        description: p.description,
        price: p.price,
        stock: p.stock,
        image: Value(p.image),
        status: Value(p.status),
        categoryId: Value(p.categoryId),
        brandId: Value(p.brandId),
        unitId: Value(p.unitId),
      )).toList());
      
      return products;
    } catch (_) {
      final entities = await _db.getAllProducts();
      if (entities.isNotEmpty) {
        return entities.map((e) => Product(
          id: e.id,
          createdAt: e.createdAt,
          updatedAt: e.updatedAt,
          deletedAt: e.deletedAt,
          code: e.code,
          name: e.name,
          description: e.description,
          price: e.price,
          stock: e.stock,
          image: e.image,
          status: e.status,
          categoryId: e.categoryId,
          brandId: e.brandId,
          unitId: e.unitId,
          category: null,
          brand: null,
          unit: null,
        )).toList();
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
      
      await _db.saveCategories(categories.map((c) => CategoriesCompanion.insert(
        id: Value(c.id),
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
        deletedAt: Value(c.deletedAt),
        name: c.name,
        status: Value(c.status),
      )).toList());
      
      return categories;
    } catch (_) {
      final entities = await _db.getAllCategories();
      if (entities.isNotEmpty) {
        return entities.map((e) => Category(
          id: e.id,
          createdAt: e.createdAt,
          updatedAt: e.updatedAt,
          deletedAt: e.deletedAt,
          name: e.name,
          status: e.status,
        )).toList();
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
      
      await _db.saveBrands(brands.map((b) => BrandsCompanion.insert(
        id: Value(b.id),
        createdAt: b.createdAt,
        updatedAt: b.updatedAt,
        deletedAt: Value(b.deletedAt),
        name: b.name,
        image: Value(b.image),
      )).toList());
      
      return brands;
    } catch (_) {
      final entities = await _db.getAllBrands();
      if (entities.isNotEmpty) {
        return entities.map((e) => Brand(
          id: e.id,
          createdAt: e.createdAt,
          updatedAt: e.updatedAt,
          deletedAt: e.deletedAt,
          name: e.name,
          image: e.image,
        )).toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/payment-methods');
      final List<dynamic> data = response.data['data'] ?? [];
      final paymentMethods = data
          .map((json) => PaymentMethod.fromJson(json as Map<String, dynamic>))
          .toList();
      
      await _db.savePaymentMethods(paymentMethods.map((pm) => PaymentMethodsCompanion.insert(
        paymentMethodId: Value(pm.paymentMethodId),
        name: pm.name,
        showInSale: pm.showInSale,
        showInPurchase: pm.showInPurchase,
        outletId: Value(pm.outletId),
      )).toList());
      
      return paymentMethods;
    } catch (_) {
      final entities = await _db.getAllPaymentMethods();
      if (entities.isNotEmpty) {
        return entities.map((e) => PaymentMethod(
          paymentMethodId: e.paymentMethodId,
          name: e.name,
          showInSale: e.showInSale,
          showInPurchase: e.showInPurchase,
          outletId: e.outletId,
        )).toList();
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
      
      await _db.savePromos(promos.map((p) => PromosCompanion.insert(
        promoId: Value(p.promoId),
        name: p.name,
        promoType: p.promoType,
        appliesTo: p.appliesTo,
        condition: p.condition,
        minQty: p.minQty,
        minTotal: p.minTotal,
        discountPct: p.discountPct,
        maxDiscount: p.maxDiscount,
        cutPrice: p.cutPrice,
        voucherType: Value(p.voucherType),
        voucherCode: Value(p.voucherCode),
        status: Value(p.status),
      )).toList());
      
      return promos;
    } catch (_) {
      final entities = await _db.getAllPromos();
      if (entities.isNotEmpty) {
        return entities.map((e) => Promo(
          promoId: e.promoId,
          name: e.name,
          promoType: e.promoType,
          appliesTo: e.appliesTo,
          condition: e.condition,
          minQty: e.minQty,
          minTotal: e.minTotal,
          discountPct: e.discountPct,
          maxDiscount: e.maxDiscount,
          cutPrice: e.cutPrice,
          voucherType: e.voucherType,
          voucherCode: e.voucherCode,
          status: e.status,
        )).toList();
      }
      rethrow;
    }
  }

  @override
  Future<PromoCheckResponse> checkVoucher(String code, List<CartItem> items) async {
    try {
      final response = await _apiClient.authenticatedDio.post(
        '/promos/check-voucher',
        data: {
          'code': code,
          'items': items
              .map((item) => {
                    'product_id': item.product.id,
                    'category_id': item.product.categoryId,
                    'brand_id': item.product.brandId,
                    'quantity': item.quantity,
                    'price': item.subtotal / item.quantity,
                  })
              .toList(),
          "subtotal": items.map((item) => item.subtotal).reduce((a, b) => a + b),
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
      final response = await _apiClient.authenticatedDio.get('/price-categories');
      final List<dynamic> data = response.data['data'] ?? [];
      final categories = data
          .map((json) => PriceCategory.fromJson(json as Map<String, dynamic>))
          .toList();
      
      await _db.savePriceCategories(categories.map((pc) => PriceCategoriesCompanion.insert(
        id: Value(pc.id),
        name: pc.name,
      )).toList());
      
      return categories;
    } catch (_) {
      final entities = await _db.getAllPriceCategories();
      if (entities.isNotEmpty) {
        return entities.map((e) => PriceCategory(
          id: e.id,
          name: e.name,
        )).toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<PriceCategoryProduct>> getPriceCategoryProducts(int categoryId) async {
    try {
      final response = await _apiClient.authenticatedDio.get('/price-categories/$categoryId/products');
      final List<dynamic> data = response.data['data'] ?? [];
      final products = data
          .map((json) => PriceCategoryProduct.fromJson(json as Map<String, dynamic>))
          .toList();
      
      await _db.savePriceCategoryProducts(categoryId, products.map((pcp) => PriceCategoryProductsCompanion.insert(
        id: Value(pcp.id),
        productId: pcp.productId,
        priceCategoryId: pcp.priceCategoryId,
        price: pcp.price,
      )).toList());
      
      return products;
    } catch (_) {
      final entities = await _db.getPriceCategoryProducts(categoryId);
      if (entities.isNotEmpty) {
        return entities.map((e) => PriceCategoryProduct(
          id: e.id,
          productId: e.productId,
          priceCategoryId: e.priceCategoryId,
          price: e.price,
          product: null,
        )).toList();
      }
      rethrow;
    }
  }
}
