import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/pages/pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            pushReplacementRoute(context, HomePage());
          } else {
            pushReplacementRoute(context, SignInPage());
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset(
                  'asset/splash.gif',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text("Getting you in..",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontStyle: FontStyle.italic)),
              ),
            ],
          );
        },
      ),
    );
  }
}
