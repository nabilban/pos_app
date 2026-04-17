import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/sale.dart';
import '../datasource/remote/api_client.dart';
import '../datasource/local/local_cache_store.dart';
import '../constants/offline_sync_constants.dart';
import 'package:uuid/uuid.dart';

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
  final Uuid _uuid = const Uuid();

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

  @override
  Future<int> getPendingOfflineSalesCount() async {
    final queue = await _cache.readList(offlineSalesQueueKey);
    return queue.length;
  }

  @override
  Future<OfflineSyncResult> syncOfflineSales() async {
    final queue = List<Map<String, dynamic>>.of(
      await _cache.readList(offlineSalesQueueKey),
    );

    if (queue.isEmpty) {
      return const OfflineSyncResult(
        message: 'Tidak ada transaksi offline untuk disinkronkan.',
        total: 0,
        created: 0,
        skipped: 0,
        failed: 0,
      );
    }

    final paymentMethodByName = await _loadPaymentMethodNameMap();
    final normalizedQueue = queue
        .map((entry) => _normalizeQueueEntry(entry, paymentMethodByName))
        .toList(growable: true);

    final transactions = normalizedQueue
        .map((entry) => Map<String, dynamic>.from(entry['transaction'] as Map))
        .toList(growable: false);

    final payload = <String, dynamic>{'transactions': transactions};
    _logSyncRequest(payload);

    late final Response<dynamic> response;
    try {
      response = await _apiClient.authenticatedDio.post(
        '/sales/sync',
        data: payload,
      );
    } on DioException catch (e) {
      _logSyncFailure(e, payload);
      rethrow;
    }

    final body = Map<String, dynamic>.from(response.data as Map);
    final results =
        (body['results'] as List?)
            ?.whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList(growable: false) ??
        const <Map<String, dynamic>>[];

    final summary = Map<String, dynamic>.from(body['summary'] as Map? ?? {});

    final Map<String, String> statusByOfflineId = {
      for (final result in results)
        result['offline_id']?.toString() ?? '':
            (result['status']?.toString().toLowerCase() ?? ''),
    };

    final remaining = normalizedQueue
        .where((entry) {
          final transaction = Map<String, dynamic>.from(
            entry['transaction'] as Map,
          );
          final offlineId = transaction['offline_id']?.toString() ?? '';
          final status = statusByOfflineId[offlineId];
          return status != 'created' && status != 'skipped';
        })
        .toList(growable: false);

    await _cache.saveList(offlineSalesQueueKey, remaining);

    return OfflineSyncResult(
      message: body['message']?.toString() ?? 'Sinkronisasi selesai',
      total: _toInt(summary['total']) ?? transactions.length,
      created: _toInt(summary['created']) ?? 0,
      skipped: _toInt(summary['skipped']) ?? 0,
      failed: _toInt(summary['failed']) ?? remaining.length,
    );
  }

  Future<Map<String, int>> _loadPaymentMethodNameMap() async {
    final response = await _apiClient.authenticatedDio.get('/payment-methods');
    final List<dynamic> data =
        response.data['data'] as List<dynamic>? ?? const [];

    final map = <String, int>{};
    for (final item in data) {
      if (item is! Map) continue;
      final json = Map<String, dynamic>.from(item);
      final name = json['name']?.toString().toLowerCase().trim();
      final id = _toInt(json['payment_method_id']);
      if (name != null && name.isNotEmpty && id != null) {
        map[name] = id;
      }
    }

    return map;
  }

  Map<String, dynamic> _normalizeQueueEntry(
    Map<String, dynamic> rawEntry,
    Map<String, int> paymentMethodByName,
  ) {
    final entry = Map<String, dynamic>.from(rawEntry);
    final existingTransaction = entry['transaction'];
    final request = existingTransaction is Map
        ? Map<String, dynamic>.from(existingTransaction)
        : (entry['request'] is Map
              ? Map<String, dynamic>.from(entry['request'] as Map)
              : <String, dynamic>{});

    int paymentMethodId = _toInt(request['payment_method_id']) ?? 0;
    if (paymentMethodId <= 0) {
      final methodName = entry['payment_method']
          ?.toString()
          .toLowerCase()
          .trim();
      if (methodName != null && methodName.isNotEmpty) {
        paymentMethodId = paymentMethodByName[methodName] ?? 0;
      }
    }
    if (paymentMethodId <= 0 && paymentMethodByName.isNotEmpty) {
      paymentMethodId = paymentMethodByName.values.first;
    }

    final offlineId = entry['offline_id']?.toString() ?? _uuid.v4();
    final soldAt =
        entry['sold_at']?.toString() ??
        entry['created_at']?.toString() ??
        DateTime.now().toUtc().toIso8601String();

    final normalizedSoldAt = _normalizeSoldAt(soldAt);

    final transaction = {
      'offline_id': offlineId,
      'customer_name':
          request['customer_name']?.toString() ?? 'Walk-in Customer',
      'payment_method_id': paymentMethodId,
      'price_category_id': request['price_category_id'],
      'promo_id': request['promo_id'],
      'source': 'offline',
      'manual_discount': _toCurrencyInt(request['manual_discount']),
      'additional_fee': _toCurrencyInt(request['additional_fee']),
      'sold_at': normalizedSoldAt,
      'items':
          (request['items'] as List?)
              ?.whereType<Map>()
              .map(
                (item) =>
                    _normalizeItemForSync(Map<String, dynamic>.from(item)),
              )
              .toList(growable: false) ??
          const <Map<String, dynamic>>[],
    };

    return {
      ...entry,
      'offline_id': offlineId,
      'sold_at': normalizedSoldAt,
      'status': 'pending',
      'transaction': transaction,
    };
  }

  Map<String, dynamic> _normalizeItemForSync(Map<String, dynamic> item) {
    return {
      'product_id': _toInt(item['product_id']) ?? item['product_id'],
      'quantity': _toInt(item['quantity']) ?? item['quantity'],
      'discount': _toCurrencyInt(item['discount']),
      'variants':
          (item['variants'] as List?)
              ?.whereType<Map>()
              .map((variant) {
                final normalized = Map<String, dynamic>.from(variant);
                normalized['variant_option_id'] =
                    _toInt(normalized['variant_option_id']) ??
                    normalized['variant_option_id'];
                return normalized;
              })
              .toList(growable: false) ??
          const <Map<String, dynamic>>[],
    };
  }

  String _normalizeSoldAt(String rawValue) {
    final parsed = DateTime.tryParse(rawValue);
    if (parsed != null) {
      return parsed.toUtc().toIso8601String();
    }
    return DateTime.now().toUtc().toIso8601String();
  }

  int _toCurrencyInt(dynamic value) {
    final numValue = _toNum(value) ?? 0;
    return numValue.round();
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  double? _toNum(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  void _logSyncRequest(Map<String, dynamic> payload) {
    if (!kDebugMode) return;
    debugPrint('===== OFFLINE SYNC REQUEST: POST /sales/sync =====');
    _debugPrintLong(const JsonEncoder.withIndent('  ').convert(payload));
  }

  void _logSyncFailure(DioException e, Map<String, dynamic> payload) {
    if (!kDebugMode) return;
    debugPrint('===== OFFLINE SYNC FAILED =====');
    debugPrint('Status code: ${e.response?.statusCode}');
    debugPrint('Dio message: ${e.message}');

    final responseBody = e.response?.data;
    if (responseBody != null) {
      try {
        debugPrint('Response body:');
        _debugPrintLong(
          const JsonEncoder.withIndent('  ').convert(responseBody),
        );
      } catch (_) {
        debugPrint('Response body: $responseBody');
      }
    }

    debugPrint('Request payload replay:');
    _debugPrintLong(const JsonEncoder.withIndent('  ').convert(payload));
  }

  void _debugPrintLong(String text) {
    final chunks = RegExp(r'.{1,800}', dotAll: true).allMatches(text);
    for (final chunk in chunks) {
      debugPrint(chunk.group(0));
    }
  }
}
