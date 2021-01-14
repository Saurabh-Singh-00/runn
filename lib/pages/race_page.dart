import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/pages/widgets/detail_chip.dart';

class RacePage extends StatelessWidget {
  final Marathon marathon;

  const RacePage({Key key, this.marathon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RaceBloc raceBloc = BlocProvider.of<RaceBloc>(context);
    final DateTime dateTime = DateTime.tryParse(marathon.dateTime);
    final String marathonDate = DateFormat.yMMMd().format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text("Race"),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: .0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (raceBloc.state is RaceEnded) {
            return true;
          }
          return await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                    title: Text('Are you sure you want to End Race'),
                    actions: <Widget>[
                      FlatButton(
                          child: Text('End Race'),
                          onPressed: () => Navigator.of(context).pop(true)),
                      FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false)),
                    ]);
              });
        },
        child: BlocBuilder<RaceBloc, RaceState>(
          cubit: raceBloc,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container()),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 0.5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 1,
                            child: DetailChip(
                              iconData: FontAwesomeIcons.calendarDay,
                              title: "End Date",
                              data: "$marathonDate",
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: DetailChip(
                              iconData: FontAwesomeIcons.stopwatch,
                              title: "Distance",
                              data: "${marathon.distance}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
