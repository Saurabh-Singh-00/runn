import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:runn/blocs/blocs.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StreamSubscription subscription;
  final AuthBloc authBloc;
  UserBloc(this.authBloc) : super(UserInitial()) {
    subscription = authBloc.listen(authBlocListener);
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }

  void authBlocListener(AuthState state) {}

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
