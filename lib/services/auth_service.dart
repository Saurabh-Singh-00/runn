import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<bool> isAuthenticated();

  Future<dynamic> signIn();

  Future<dynamic> signOut();
}

class GoogleAuth implements AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount account;

  @override
  Future<bool> isAuthenticated() async {
    return await _googleSignIn.isSignedIn();
  }

  @override
  Future<Either<Exception, GoogleSignInAccount>> signIn() async {
    Either<Exception, GoogleSignInAccount> either =
        await Task(_googleSignIn.signInSilently)
            .attempt()
            .map((a) => a.leftMap((l) => (l as Exception)))
            .run();
    if (either.isRight()) {
      account = either.fold((l) => null, (r) => r);
    }
    return either;
  }

  GoogleSignInAccount get currentUser => _googleSignIn.currentUser;

  @override
  Future signOut() async {}
}
