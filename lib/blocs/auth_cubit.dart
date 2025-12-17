import 'package:final_project_news_app/blocs/auth_state.dart';
import 'package:final_project_news_app/data/locat_storage/user_service.dart';
import 'package:final_project_news_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserService userService;
  final _uuid = Uuid();

  AuthCubit(this.userService) : super(AuthState(isAuthenticated: false));

  Future<void> register(
    String email,
    String password,
    String phoneNumber,
  ) async {
    final user = UserModel(id: _uuid.v4(), email: email, password: password);

    await userService.register(user);
    emit(state.copyWith(user: user, isAuthenticated: true));
  }

  Future<void> login(String email, String password) async {
    final user = await userService.login(email, password);
    if (user != null) {
      emit(state.copyWith(user: user, isAuthenticated: true));
    } else {
      emit(AuthState(isAuthenticated: false));
    }
  }

  Future<void> updateProfile({String? name, String? address}) async {
    final currentUser = state.user;
    if (currentUser != null) {
      final updateUser = UserModel(
        id: currentUser.id,
        email: currentUser.email,
        password: currentUser.password,
        phoneNumber: currentUser.phoneNumber,
        name: currentUser.name,
        address: currentUser.address,
      );

      await userService.updateProfile(updateUser);

      emit(state.copyWith(user: updateUser));
    }
  }

  void logut() {
    emit(AuthState(isAuthenticated: false));
  }
}
