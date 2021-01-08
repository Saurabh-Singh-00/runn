import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/pages/pages.dart';

void main() {
  injector.setup();
  runApp(Runn());
}

class Runn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarathonBloc>(
          create: (context) => MarathonBloc()
            ..add(
              LoadMarathon({}),
            ),
        ),
      ],
      child: MaterialApp(
        title: "Runn",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
    );
  }
}
