import '../models/auth_response.dart' as model;
import '../datasource/local/user_manager.dart';
import '../models/role.dart' as model_role;
import '../models/outlet.dart' as model_outlet;

abstract class IUserRepository {
  Future<model.User?> getCurrentUser();
}

class UserRepository implements IUserRepository {
  final UserManager _userManager;

  UserRepository(this._userManager);

  @override
  Future<model.User?> getCurrentUser() async {
    final user = await _userManager.getActiveUser();
    if (user == null) return null;

    final role = await _userManager.getActiveRole();
    final outlet = await _userManager.getActiveOutlet();

    return model.User(
      id: user.id,
      createdAt: '',
      updatedAt: '',
      name: user.name,
      username: user.username,
      email: user.email,
      roleId: user.roleId,
      canAccessCenter: user.canAccessCenter,
      outletId: user.outletId,
      role: model_role.Role(
        id: role?.id ?? 0,
        createdAt: '',
        updatedAt: '',
        name: role?.name ?? '',
      ),
      outlet: outlet != null
          ? model_outlet.Outlet(
              id: outlet.id,
              createdAt: '',
              updatedAt: '',
              name: outlet.name,
              address: outlet.address,
              phone: outlet.phone,
              status: outlet.status,
            )
          : null,
    );
  }
}
