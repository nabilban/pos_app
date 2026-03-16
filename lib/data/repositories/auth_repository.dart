import '../models/auth_response.dart';
import '../datasource/remote/api_client.dart';
import '../datasource/local/token_manager.dart';

abstract class IAuthRepository {
  Future<AuthResponse> login(String username, String password);
  Future<void> logout();
}

class AuthRepository implements IAuthRepository {
  final ApiClient _apiClient;
  final TokenManager _tokenManager;

  AuthRepository(this._apiClient, this._tokenManager);

  @override
  Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await _apiClient.cleanDio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      // Parse the response into our Freezed model
      final authResponse = AuthResponse.fromJson(response.data);

      // Save token and user info locally
      await _tokenManager.saveAuthData(
        token: authResponse.token,
        userName: authResponse.user.name,
        roleName: authResponse.user.role.name,
        outletName: authResponse.user.outlet?.name,
      );

      return authResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _tokenManager.deleteToken();
    // Optionally alert the server
    // try { await _apiClient.dio.post('/logout'); } catch (_) {}
  }
}
