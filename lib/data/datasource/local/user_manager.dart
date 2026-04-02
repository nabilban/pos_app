import '../../database/app_database.dart';

class UserManager {
  final AppDatabase _db;

  UserManager(this._db);

  /// Saves the full user context locally
  Future<void> saveUserContext({
    required UsersCompanion user,
    required RolesCompanion role,
    OutletsCompanion? outlet,
  }) async {
    await _db.saveUserContext(user: user, role: role, outlet: outlet);
  }

  /// Retrieves the current user
  Future<User?> getActiveUser() async {
    return _db.getActiveUser();
  }

  /// Retrieves the active role
  Future<Role?> getActiveRole() async {
    return _db.getActiveRole();
  }

  /// Retrieves the active outlet
  Future<Outlet?> getActiveOutlet() async {
    return _db.getActiveOutlet();
  }

  /// Clears all user context
  Future<void> clearUserContext() async {
    await _db.clearUserContext();
  }
}
