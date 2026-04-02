import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../local/token_manager.dart';

class ApiClient {
  final Dio cleanDio;
  final Dio authenticatedDio;
  final TokenManager _tokenManager;

  ApiClient(this.cleanDio, this._tokenManager, {VoidCallback? onUnauthorized})
    : authenticatedDio = Dio(cleanDio.options) {
    _addInterceptors(authenticatedDio, onUnauthorized, true);
    _addInterceptors(cleanDio, onUnauthorized, false);
  }

  void _addInterceptors(Dio dio, VoidCallback? onUnauthorized, bool isAuth) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (isAuth) {
            final token = await _tokenManager.getToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // 401/403 Handling (only for auth dio or always if we want to force logout)
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            await _tokenManager.deleteToken();
            onUnauthorized?.call();
            return handler.next(e);
          }

          // Internet / Connection Handling
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

  /// Backward compatibility getter
  Dio get dio => authenticatedDio;
}
