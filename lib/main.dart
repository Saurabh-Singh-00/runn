import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/pages/splash_page.dart';

void main() {
  injector.setup();
  runApp(Runn(
    authBloc: AuthBloc(),
  ));
}

class Runn extends StatelessWidget {
  final AuthBloc authBloc;

  Runn({Key key, this.authBloc}) : super(key: key) {
    authBloc.add(Authenticate());
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => authBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(authBloc),
          lazy: false,
        ),
        BlocProvider<MarathonBloc>(
          create: (context) => MarathonBloc()
            ..add(
              LoadMarathon({}),
            ),
        ),
        BlocProvider<RunnerBloc>(
          create: (context) => RunnerBloc(),
        ),
        BlocProvider<ParticipationBloc>(
          create: (context) => ParticipationBloc(),
        ),
        BlocProvider<MyrunnBloc>(
          create: (context) => MyrunnBloc(authBloc),
          lazy: false,
        ),
        BlocProvider<RaceBloc>(
          create: (context) => RaceBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Runn",
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFEFEFEF),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
    );
  }
}
