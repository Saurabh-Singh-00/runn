part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final GoogleSignInAccount account;

  Authenticated(this.account);
}

class UnAuthenticated extends AuthState {}
