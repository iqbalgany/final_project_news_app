// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:final_project_news_app/models/user_model.dart';

class AuthState {
  final UserModel? user;
  final bool isAuthenticated;

  AuthState({this.user, this.isAuthenticated = false});

  AuthState copyWith({UserModel? user, bool? isAuthenticated}) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
