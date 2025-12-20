import 'package:final_project_news_app/blocs/auth/auth_state.dart';
import 'package:final_project_news_app/data/locat_storage/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final user = await _authService.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthLoggetOut());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.register(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final user = await _authService.login(email: email, password: password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String address,
  }) async {
    if (state is AuthSuccess) {
      final currentUser = (state as AuthSuccess).user;

      emit(AuthLoading());
      try {
        final user = await _authService.updateProfile(
          userId: currentUser.id,
          name: name,
          address: address,
        );

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    }
  }

  Future<void> fetchUser() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthLoggetOut());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    emit(AuthLoggetOut());
  }
}
