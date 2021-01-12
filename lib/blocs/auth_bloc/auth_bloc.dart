import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuth googleAuth = injector.get<AuthService>();
  AuthBloc() : super(AuthInitial());
  GoogleSignInAccount account;

  Stream<AuthState> mapAuthenticateToState(Authenticate event) async* {
    yield Authenticating();
    Either<Exception, GoogleSignInAccount> either = await googleAuth.signIn();
    if (either.isRight()) {
      account = either.fold((l) => null, (r) => r);
    }
    AuthState authState = either.fold((l) => UnAuthenticated(),
        (r) => r == null ? UnAuthenticated() : Authenticated(r));
    yield authState;
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Authenticate) {
      yield* mapAuthenticateToState(event);
    }
  }
}
