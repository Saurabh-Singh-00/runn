import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/models/marathon.dart';

class RacePage extends StatelessWidget {
  final Marathon marathon;

  const RacePage({Key key, this.marathon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RaceBloc raceBloc = BlocProvider.of<RaceBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Race"),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: .0,
      ),
      body: BlocBuilder<RaceBloc, RaceState>(
        cubit: raceBloc,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${marathon.title}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<int>(
                    initialData: 0,
                    stream: raceBloc.stopWatchTimer.minuteTime,
                    builder: (context, snapshot) {
                      return TimeComponent(
                        data: "${snapshot.data ~/ 60}",
                        title: "HRS",
                      );
                    },
                  ),
                  StreamBuilder<int>(
                    initialData: 0,
                    stream: raceBloc.stopWatchTimer.minuteTime,
                    builder: (context, snapshot) {
                      return TimeComponent(
                        data: "${snapshot.data % 60}",
                        title: "MINS",
                      );
                    },
                  ),
                  StreamBuilder<int>(
                    initialData: 0,
                    stream: raceBloc.stopWatchTimer.secondTime,
                    builder: (context, snapshot) {
                      return TimeComponent(
                        data: "${snapshot.data % 60}",
                        title: "SECS",
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      shape: StadiumBorder(),
                      color: (state is RaceStarted)
                          ? Colors.redAccent
                          : Colors.green,
                      onPressed: () async {
                        if (state is RaceStarted) {
                          raceBloc.add(EndRace());
                        } else {
                          GoogleSignInAccount acc =
                              BlocProvider.of<AuthBloc>(context).account;
                          Either<Exception, Position> either =
                              await raceBloc.determinePosition();
                          either.fold((l) {}, (r) {
                            raceBloc.add(StartRace(marathon.id, acc.email));
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Text(
                          (state is RaceStarted) ? "Stop" : "Start",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class TimeComponent extends StatelessWidget {
  final String data;
  final String title;
  const TimeComponent({
    Key key,
    this.data,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                "$data",
                style: GoogleFonts.anton(
                  textStyle: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Flexible(
              child: Text(
                "$title",
                style: GoogleFonts.anton(
                  textStyle: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
