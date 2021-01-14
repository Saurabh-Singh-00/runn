part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoadingUser extends UserState {}

class UserLoadingFailed extends UserState {
  final String message;

  UserLoadingFailed(this.message);
}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

class LoadingUserStats extends UserState {}

class UserStatsLoadingFailed extends UserState {
  final String message;

  UserStatsLoadingFailed(this.message);
}

class UserStatsLoaded extends UserState {
  final UserStats userStats;

  UserStatsLoaded(this.userStats);
}
