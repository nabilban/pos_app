import '../models/auth_response.dart';

abstract class IUserRepository {
  Future<User?> getCurrentUser();
}

class UserRepository implements IUserRepository {
  // In a real app, this might fetch from a local DB or cache
  // For now, we'll keep it as a placeholder interface
  
  @override
  Future<User?> getCurrentUser() async {
    // To be implemented when we have a local cache for the user profile
    return null;
  }
}
