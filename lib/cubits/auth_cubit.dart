import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../data/repositories/auth_repository.dart';
import '../data/datasource/local/token_manager.dart';
import '../data/repositories/user_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final TokenManager _tokenManager;

  AuthCubit(this._authRepository, this._userRepository, this._tokenManager)
    : super(const AuthState.initial());

  /// Checks if a token already exists on app startup
  Future<void> checkAuthStatus() async {
    final user = await _userRepository.getCurrentUser();
    final token = await _tokenManager.getToken();

    if (token != null && token.isNotEmpty && user != null) {
      if (user.roleId == 3) {
        emit(AuthState.authenticated(token: token, user: user));
      } else {
        await logout();
      }
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
      final message = e is DioException ? (e.message ?? e.toString()) : e.toString();
      emit(AuthState.error(message));
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
