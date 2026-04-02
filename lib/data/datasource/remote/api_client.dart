import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../local/token_manager.dart';

class ApiClient {
  final Dio dio;
  final TokenManager _tokenManager;

  ApiClient(this.dio, this._tokenManager, {VoidCallback? onUnauthorized}) {
    _addInterceptors(onUnauthorized);
  }

  void _addInterceptors(VoidCallback? onUnauthorized) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Inject token if available
          final token = await _tokenManager.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // 401/403 Handling: clear credentials and trigger logout
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            await _tokenManager.deleteToken();
            onUnauthorized?.call();
            return handler.next(e);
          }

          // User-friendly error messaging for connection issues
          String message;
          switch (e.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.sendTimeout:
            case DioExceptionType.receiveTimeout:
              message = 'Koneksi terputus. Silakan coba lagi.';
              break;
            case DioExceptionType.connectionError:
              message = 'Internet tidak ditemukan. Periksa koneksi Anda.';
              break;
            case DioExceptionType.unknown:
              if (e.message?.contains('SocketException') ?? false) {
                message = 'Internet tidak ditemukan. Periksa koneksi Anda.';
              } else {
                message = 'Terjadi kesalahan tidak terduga.';
              }
              break;
            default:
              message = e.message ?? 'Terjadi kesalahan sistem.';
          }

          final customError = e.copyWith(message: message);
          return handler.next(customError);
        },
      ),
    );
  }

  /// Alias for backward compatibility
  Dio get cleanDio => dio;
  Dio get authenticatedDio => dio;
}
