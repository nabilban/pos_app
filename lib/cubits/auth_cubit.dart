import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../data/datasource/local/token_manager.dart';
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
      emit(AuthState.authenticated(token: token));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  /// Attempts to log in
  Future<void> login(String username, String password) async {
    emit(const AuthState.loading());
    try {
      final response = await _authRepository.login(username, password);
      emit(AuthState.authenticated(token: response.token));
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
