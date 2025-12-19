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
    print('🟢 CUBIT REGISTER - Mulai register');
    print('   Email: $email');
    print('   Password: $password');
    print('   Phone: $phoneNumber');

    emit(AuthLoading());
    try {
      print('🟢 CUBIT - Memanggil _authService.register()...');
      final user = await _authService.register(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      print('🟢 CUBIT - Register berhasil! User: ${user.email}');
      emit(AuthSuccess(user));
    } catch (e) {
      print('🔴 CUBIT - Register error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    print('🟢 CUBIT LOGIN - Mulai login');
    print('   Email: $email');
    print('   Password: $password');

    emit(AuthLoading());
    try {
      print('🟢 CUBIT - Memanggil _authService.login()...');
      final user = await _authService.login(email: email, password: password);
      print('🟢 CUBIT - Login berhasil! User: ${user.email}');
      emit(AuthSuccess(user));
    } catch (e) {
      print('🔴 CUBIT - Login error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String address,
  }) async {
    if (state is AuthSuccess) {
      print('🟢 CUBIT - Updating profile...');

      final currentUser = (state as AuthSuccess).user;

      emit(AuthLoading());
      try {
        print('🟢 CUBIT - Memanggil _authService.updateProfile()...');
        final user = await _authService.updateProfile(
          userId: currentUser.id,
          name: name,
          address: address,
        );
        print('🟢 CUBIT - Update profile berhasil!');

        emit(AuthSuccess(user));
      } catch (e) {
        print('🔴 CUBIT - Update profile error: $e');
        emit(AuthError(e.toString()));
      }
    }
  }

  Future<void> fetchUser() async {
    print('🔄 CUBIT - Fetching current user data...');
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        print('🔄 CUBIT - User data fetched: ${user.email}');
        emit(AuthSuccess(user));
      } else {
        print('🔄 CUBIT - No user logged in');
        emit(AuthLoggetOut());
      }
    } catch (e) {
      print('🔴 CUBIT - Fetch user error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    emit(AuthLoggetOut());
  }
}
