import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/user.dart';
import 'package:runn/models/user_stats.dart';
import 'package:runn/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StreamSubscription subscription;
  final UserRepository userRepository;
  final AuthBloc authBloc;
  UserBloc(this.authBloc, {UserRepository userRepository})
      : this.userRepository = userRepository ?? injector.get<UserRepository>(),
        super(UserInitial()) {
    subscription = authBloc.listen(authBlocListener);
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }

  void authBlocListener(AuthState state) {
    if (state is Authenticated) {
      add(LoadUser(state.account.email));
    } else if (state is UnAuthenticated) {
      add(ResetUser());
    }
  }

  Stream<UserState> mapLoadUserToState(LoadUser event) async* {
    yield LoadingUser();
    Either<Exception, User> either =
        await userRepository.fetchUserDetails(event.email);
    UserState userState = either.fold(
        (l) => UserLoadingFailed(l.toString()), (r) => UserLoaded(r));
    if (userState is UserLoaded) {
      add(LoadUserStats(userState.user.email));
    }
    yield userState;
  }

  Stream<UserState> mapLoadUserStatsToState(LoadUserStats event) async* {
    yield LoadingUserStats();
    Either<Exception, UserStats> either =
        await userRepository.fetchUserStats(event.email);
    UserState userState = either.fold(
        (l) => UserStatsLoadingFailed(l.toString()), (r) => UserStatsLoaded(r));
    yield userState;
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      yield* mapLoadUserToState(event);
    } else if (event is LoadUserStats) {
      yield* mapLoadUserStatsToState(event);
    } else if (event is ResetUser) {
      yield UserInitial();
    }
  }
}
