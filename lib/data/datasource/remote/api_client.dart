import 'package:dio/dio.dart';
import '../local/token_manager.dart';

class ApiClient {
  final Dio cleanDio;
  final Dio authenticatedDio;
  final TokenManager _tokenManager;

  ApiClient(this.cleanDio, this._tokenManager)
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
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  /// Backward compatibility getter
  Dio get dio => authenticatedDio;
}
