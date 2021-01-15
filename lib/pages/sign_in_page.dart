import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/pages/home_page.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            pushReplacementRoute(context, HomePage());
          } else {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Please sign in to proceed")));
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Container()),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(
                'asset/logo.png',
                fit: BoxFit.fitHeight,
                color: Colors.redAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text("Runn",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                  "Of all the races, there is no better stage for heroism than a marathon.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontStyle: FontStyle.italic)),
            ),
            Expanded(child: Container()),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: RaisedButton.icon(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(Authenticate());
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Icon(FontAwesomeIcons.google, color: Colors.white),
                ),
                label: Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 16.0, right: 24.0),
                  child: Text(
                    "Sign In with Google",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
