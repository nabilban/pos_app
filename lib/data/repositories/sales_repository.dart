import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/sale.dart';
import '../datasource/remote/api_client.dart';
import '../datasource/local/local_cache_store.dart';
import '../database/app_database.dart';
import '../constants/offline_sync_constants.dart';
import 'package:drift/drift.dart';

class OfflineSyncResult {
  final String message;
  final int total;
  final int created;
  final int skipped;
  final int failed;

  const OfflineSyncResult({
    required this.message,
    required this.total,
    required this.created,
    required this.skipped,
    required this.failed,
  });
}

abstract class ISalesRepository {
  Future<List<Sale>> getSales();
  Future<int> getPendingOfflineSalesCount();
  Future<OfflineSyncResult> syncOfflineSales();
}

class SalesRepository implements ISalesRepository {
  final ApiClient _apiClient;
  final LocalCacheStore _cache;
  final AppDatabase _db;

  SalesRepository(this._apiClient, this._cache, this._db);

  @override
  Future<List<Sale>> getSales() async {
    try {
      final response = await _apiClient.authenticatedDio.get('/sales');
      final List<dynamic> data = response.data['data'] ?? [];
      final sales = data
          .map((json) => Sale.fromJson(json as Map<String, dynamic>))
          .toList();
      
      await _db.saveSalesHistory(sales.map((s) => SalesCompanion.insert(
        id: Value(s.id),
        createdAt: s.createdAt,
        invoiceNumber: s.invoiceNumber,
        customerName: Value(s.customerName),
        paymentMethodId: s.paymentMethodId,
        subtotal: Value(s.subtotal),
        discountTotal: Value(s.discountTotal),
        manualDiscount: Value(s.manualDiscount),
        additionalFee: Value(s.additionalFee),
        grandTotal: Value(s.grandTotal),
        source: Value(s.source),
        userName: Value(s.user?.name),
      )).toList());
      
      return sales;
    } catch (_) {
      final entities = await _db.getAllSales();
      if (entities.isNotEmpty) {
        return entities.map((e) => Sale(
          id: e.id,
          createdAt: e.createdAt,
          invoiceNumber: e.invoiceNumber,
          customerName: e.customerName,
          paymentMethodId: e.paymentMethodId,
          subtotal: e.subtotal,
          discountTotal: e.discountTotal,
          manualDiscount: e.manualDiscount,
          additionalFee: e.additionalFee,
          grandTotal: e.grandTotal,
          source: e.source,
          user: e.userName != null ? SaleUser(id: 0, name: e.userName!) : null,
          paymentMethod: null,
          items: const [], // Simplified for offline fallback
        )).toList();
      }
      rethrow;
    }
  }

  @override
  Future<int> getPendingOfflineSalesCount() async {
    final cached = await _cache.readList(offlineSalesQueueKey);
    return cached.length;
  }

  @override
  Future<OfflineSyncResult> syncOfflineSales() async {
    final cached = await _cache.readList(offlineSalesQueueKey);
    if (cached.isEmpty) {
      return const OfflineSyncResult(
        message: 'Tidak ada data untuk disinkronkan',
        total: 0,
        created: 0,
        skipped: 0,
        failed: 0,
      );
    }

    try {
      final List<Map<String, dynamic>> transactions = cached
          .map((item) => Map<String, dynamic>.from(item['transaction']))
          .toList();

      final response = await _apiClient.authenticatedDio.post(
        '/sales/sync',
        data: {'transactions': transactions},
      );

      final summary = response.data['summary'] ?? {};
      final int total = summary['total'] ?? cached.length;
      final int created = summary['created'] ?? 0;
      final int skipped = summary['skipped'] ?? 0;
      final int failed = summary['failed'] ?? 0;

      // If everything is processed (created + skipped), we can clear the queue.
      // If there are failures, the simple approach is to clear ONLY successful ones,
      // but usually a batch sync either works or provides specific error per index.
      // For now, if code is 200, we clear the queue as the API handles duplicates (skipped).
      await _cache.saveList(offlineSalesQueueKey, []);

      return OfflineSyncResult(
        message: response.data['message'] ?? 'Sinkronisasi selesai',
        total: total,
        created: created,
        skipped: skipped,
        failed: failed,
      );
    } catch (e) {
      if (kDebugMode) {
        print('--- BATCH SYNC DEBUG START ---');
        print('Sync failed: $e');
        if (e is DioException) {
          print('Status code: ${e.response?.statusCode}');
          print('Error response: ${e.response?.data}');
          print('Request path: ${e.requestOptions.path}');
        }
        print('--- BATCH SYNC DEBUG END ---');
      }
      
      return OfflineSyncResult(
        message: 'Gagal sinkronisasi: $e',
        total: cached.length,
        created: 0,
        skipped: 0,
        failed: cached.length,
      );
    }
  }
}
