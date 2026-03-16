import '../models/auth_response.dart';
import '../datasource/local/token_manager.dart';
import '../models/role.dart';
import '../models/outlet.dart';

abstract class IUserRepository {
  Future<User?> getCurrentUser();
}

class UserRepository implements IUserRepository {
  final TokenManager _tokenManager;

  UserRepository(this._tokenManager);

  @override
  Future<User?> getCurrentUser() async {
    final authData = await _tokenManager.getAuthData();
    if (authData['token'] == null) return null;

    // Construct a partial User object from local storage
    return User(
      id: 0, // ID not strictly needed for UI display if we just use the name
      createdAt: '',
      updatedAt: '',
      name: authData['userName'] ?? 'User',
      username: '',
      email: '',
      roleId: 0,
      canAccessCenter: false,
      role: Role(
        id: 0,
        createdAt: '',
        updatedAt: '',
        name: authData['roleName'] ?? '',
      ),
      outlet: Outlet(
        id: 0,
        createdAt: '',
        updatedAt: '',
        name: authData['outletName'] ?? '',
        address: '',
        phone: '',
        status: '',
      ),
    );
  }
}
