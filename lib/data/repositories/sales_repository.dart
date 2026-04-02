import '../models/sale.dart';
import '../datasource/remote/api_client.dart';

abstract class ISalesRepository {
  Future<List<Sale>> getSales();
}

class SalesRepository implements ISalesRepository {
  final ApiClient _apiClient;

  SalesRepository(this._apiClient);

  @override
  Future<List<Sale>> getSales() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/sales');
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => Sale.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
