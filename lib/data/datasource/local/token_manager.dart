import '../../database/app_database.dart';

class TokenManager {
  final AppDatabase _db;

  TokenManager(this._db);

  /// Saves the token and user info to the local SQLite database
  Future<void> saveAuthData({
    required String token,
    String? userName,
    String? roleName,
    String? outletName,
  }) async {
    await _db.saveAuthData(
      token: token,
      userName: userName,
      roleName: roleName,
      outletName: outletName,
    );
  }

  /// Retrieves the current token from the database
  Future<String?> getToken() async {
    return _db.getActiveToken();
  }

  /// Retrieves all auth data
  Future<Map<String, String?>> getAuthData() async {
    return _db.getAuthData();
  }

  /// Deletes the currently stored token and user info
  Future<void> deleteToken() async {
    await _db.clearAuthData();
  }

  /// Synchronous check if a token might exist (optional usefulness if we async load)
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
