import '../models/sale.dart';
import '../datasource/remote/api_client.dart';
import '../datasource/local/local_cache_store.dart';

abstract class ISalesRepository {
  Future<List<Sale>> getSales();
}

class SalesRepository implements ISalesRepository {
  final ApiClient _apiClient;
  final LocalCacheStore _cache;

  static const _salesKey = 'history_sales';

  SalesRepository(this._apiClient, this._cache);

  @override
  Future<List<Sale>> getSales() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/sales');
      final List<dynamic> data = response.data['data'] ?? [];
      final sales = data
          .map((json) => Sale.fromJson(json as Map<String, dynamic>))
          .toList();
      await _cache.saveList(
        _salesKey,
        sales.map((e) => e.toJson()).toList(growable: false),
      );
      return sales;
    } catch (_) {
      final cached = await _cache.readList(_salesKey);
      if (cached.isNotEmpty) {
        return cached.map(Sale.fromJson).toList(growable: false);
      }
      rethrow;
    }
  }
}
