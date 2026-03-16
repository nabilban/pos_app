import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/data/models/role.dart';
import '../data/repositories/auth_repository.dart';
import '../data/datasource/local/token_manager.dart';
import '../data/models/auth_response.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _authRepository;
  final TokenManager _tokenManager;

  AuthCubit(this._authRepository, this._tokenManager)
    : super(const AuthState.initial());

  /// Checks if a token already exists on app startup
  Future<void> checkAuthStatus() async {
    final token = await _tokenManager.getToken();
    if (token != null && token.isNotEmpty) {
      // TODO: Fetch user profile from repository/local database
      // For now, emit a dummy User so the app still functions
      emit(
        AuthState.authenticated(
          token: token,
          user: const User(
            id: 0,
            name: 'Loading...',
            username: '',
            email: '',
            roleId: 0,
            canAccessCenter: false,
            role: Role(id: 0, name: '', createdAt: '', updatedAt: ''),
            createdAt: '',
            updatedAt: '',
          ),
        ),
      );
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  /// Attempts to log in
  Future<void> login(String username, String password) async {
    emit(const AuthState.loading());
    try {
      final response = await _authRepository.login(username, password);
      emit(AuthState.authenticated(token: response.token, user: response.user));
    } catch (e) {
      // Revert to unauthenticated with an error
      emit(AuthState.error(e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  /// Logs the user out
  Future<void> logout() async {
    emit(const AuthState.loading());
    await _authRepository.logout();
    emit(const AuthState.unauthenticated());
  }
}
