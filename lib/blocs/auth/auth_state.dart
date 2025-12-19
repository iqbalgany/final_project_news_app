// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:final_project_news_app/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggetOut extends AuthState {}
