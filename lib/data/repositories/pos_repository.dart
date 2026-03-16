import '../models/product.dart';
import '../models/store_info.dart';
import '../product_data.dart';
import '../user_data.dart';

abstract class IPosRepository {
  Future<List<Product>> getProducts();
  Future<List<String>> getCategories();
  Future<StoreInfo> getStoreInfo();
}

class PosRepository implements IPosRepository {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return allProducts;
  }

  @override
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return productCategories;
  }

  @override
  Future<StoreInfo> getStoreInfo() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return currentUser;
  }
}
