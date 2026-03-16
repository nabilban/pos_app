import '../../database/app_database.dart';

class TokenManager {
  final AppDatabase _db;

  TokenManager(this._db);

  /// Saves the token to the local SQLite database
  Future<void> saveToken(String token) async {
    await _db.saveToken(token);
  }

  /// Retrieves the current token from the database
  Future<String?> getToken() async {
    return _db.getActiveToken();
  }

  /// Deletes the currently stored token
  Future<void> deleteToken() async {
    await _db.clearToken();
  }

  /// Synchronous check if a token might exist (optional usefulness if we async load)
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
