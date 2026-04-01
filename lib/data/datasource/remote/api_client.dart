import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../local/token_manager.dart';

class ApiClient {
  final Dio cleanDio;
  final Dio authenticatedDio;
  final TokenManager _tokenManager;

  ApiClient(this.cleanDio, this._tokenManager, {VoidCallback? onUnauthorized})
    : authenticatedDio = Dio(cleanDio.options) {
    // Interceptor to inject the bearer token into authenticatedDio
    authenticatedDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenManager.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // Token expired — clear local credentials and trigger logout
            await _tokenManager.deleteToken();
            onUnauthorized?.call();
          }
          return handler.next(e);
        },
      ),
    );
  }

  /// Backward compatibility getter
  Dio get dio => authenticatedDio;
}
