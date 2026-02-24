import '../models/product.dart';
import '../models/store_info.dart';
import '../data/product_data.dart';
import '../data/user_data.dart';

class PosRepository {
  Future<List<Product>> getProducts() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    return allProducts;
  }

  Future<List<String>> getCategories() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 100));
    return productCategories;
  }

  Future<StoreInfo> getStoreInfo() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 200));
    return currentUser;
  }
}
