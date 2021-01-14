part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUser extends UserEvent {
  final String email;

  LoadUser(this.email);
}

class LoadUserStats extends UserEvent {
  final String email;

  LoadUserStats(this.email);
}

class ResetUser extends UserEvent {}
