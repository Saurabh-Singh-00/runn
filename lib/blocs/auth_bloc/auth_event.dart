part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Authenticate extends AuthEvent {}

class AuthenticateSilently extends AuthEvent {}

class SignOut extends AuthEvent {}
