import '../models/auth_response.dart';
import '../datasource/remote/api_client.dart';
import '../datasource/local/token_manager.dart';

import '../datasource/local/user_manager.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart';

abstract class IAuthRepository {
  Future<AuthResponse> login(String username, String password);
  Future<void> logout();
}

class AuthRepository implements IAuthRepository {
  final ApiClient _apiClient;
  final TokenManager _tokenManager;
  final UserManager _userManager;

  AuthRepository(this._apiClient, this._tokenManager, this._userManager);

  @override
  Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await _apiClient.cleanDio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      // Parse the response into our Freezed model
      final authResponse = AuthResponse.fromJson(response.data);

      // Save token locally
      await _tokenManager.saveToken(authResponse.token);

      // Save user relational info
      final u = authResponse.user;
      final role = u.role;
      final outlet = u.outlet;

      await _userManager.saveUserContext(
        user: UsersCompanion.insert(
          id: Value(
            u.id,
          ), // We can use Value if we change the ID to not auto increment, or just let drift handle it if we actually want the remote ID. Wait, I didn't set auto-increment in users table, so we must provide the ID.
          name: u.name,
          username: u.username,
          email: u.email,
          roleId: u.roleId,
          outletId: Value(u.outletId),
          canAccessCenter: u.canAccessCenter,
        ),
        role: RolesCompanion.insert(id: Value(role.id), name: role.name),
        outlet: outlet != null
            ? OutletsCompanion.insert(
                id: Value(outlet.id),
                name: outlet.name,
                address: outlet.address,
                phone: outlet.phone,
                status: outlet.status,
              )
            : null,
      );

      return authResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _tokenManager.deleteToken();
    await _userManager.clearUserContext();
    // Optionally alert the server
    // try { await _apiClient.dio.post('/logout'); } catch (_) {}
  }
}
