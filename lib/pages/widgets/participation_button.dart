import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/models/runner.dart';
import 'package:runn/models/user_stats_by_marathon.dart';
import 'package:runn/pages/race_page.dart';
import 'package:runn/pages/user_stats_page.dart';

class ParticipateButton extends StatelessWidget {
  final Marathon marathon;
  final DateTime dateTime;
  final DateTime now = DateTime.now();

  ParticipateButton({
    Key key,
    this.marathon,
  })  : this.dateTime = DateTime.tryParse(marathon.dateTime),
        super(key: key);

  String buildParticipationText(ParticipationState state) {
    if (state is CheckingParticipation || state is ParticipationInitial)
      return "Checking..";
    if (state is Participating) return "Participating";
    if (state is Participated && dateTime != null && dateTime.isAfter(now))
      return "Start";
    if (state is Participated && dateTime != null && dateTime.isBefore(now))
      return "Show Stats";
    if (state is CheckingParticipationFailed &&
        dateTime != null &&
        dateTime.isAfter(now)) return "Join the Runn";
    if (state is CheckingParticipationFailed &&
        dateTime != null &&
        dateTime.isBefore(now)) return "Race is Over";
    if (state is ParticipationFailed) return "Oops! Please try again";
    return "Participate";
  }

  void participate(ParticipationBloc bloc, GoogleSignInAccount acc) {
    bloc.add(
      Participate(
        Runner(
          marathonId: marathon.id,
          marathonCountry: marathon.country,
          email: acc.email,
          name: acc.displayName,
          joinedAt: null,
          participationType: 'VIRTUAL',
          pic: acc.photoUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount acc = BlocProvider.of<AuthBloc>(context).account;

    ParticipationBloc participationBloc =
        BlocProvider.of<ParticipationBloc>(context);

    participationBloc
        .add(CheckParticipation(marathon.id, marathon.country, acc.email));

    final DateTime dateTime = DateTime.tryParse(marathon.dateTime);
    final DateTime now = DateTime.now();

    return BlocBuilder<ParticipationBloc, ParticipationState>(
      buildWhen: (prevState, state) {
        return !(state is ParticipationInitial);
      },
      builder: (context, state) {
        return RaisedButton(
          onPressed: () async {
            if (state is CheckingParticipationFailed ||
                state is ParticipationFailed) {
              if (dateTime.isAfter(now)) {
                participate(participationBloc, acc);
                BlocProvider.of<MyrunnBloc>(context)
                    .add(LoadMarathonsByRunner(acc.email));
              }
            } else if (state is Participated) {
              AlertDialog alert(String title,
                      {String actionText,
                      Widget display,
                      VoidCallback onPressed}) =>
                  AlertDialog(
                    content: new Row(
                      children: [
                        display ?? CircularProgressIndicator(),
                        Flexible(
                          child: Container(
                              margin: EdgeInsets.only(left: 16.0),
                              child: Text("$title")),
                        ),
                      ],
                    ),
                    actionsPadding: EdgeInsets.only(right: 8.0),
                    actions: [
                      FlatButton(
                        onPressed: onPressed ??
                            () {
                              Navigator.of(context).pop();
                            },
                        child: Text(actionText ?? "Go Back"),
                      )
                    ],
                  );

              Either<Exception, UserStatsByMarathon> either =
                  await participationBloc.marathonRepository
                      .checkParticipation(marathon.id, acc.email);
              either.fold((l) {
                if (dateTime.isAfter(now)) {
                  BlocProvider.of<RaceBloc>(context).add(LoadRace());
                  pushRoute(
                      context,
                      RacePage(
                        marathon: marathon,
                      ));
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert(
                        "You did not run in this Marathon",
                        display: Icon(
                          FontAwesomeIcons.running,
                          color: Colors.red,
                        ),
                      );
                    },
                  );
                }
              }, (r) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return alert("You have already finished the Race!",
                        display: Icon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.green,
                        ),
                        actionText: "Show Stats", onPressed: () {
                      pushReplacementRoute(
                        context,
                        UserStatsPage(
                          marathonId: marathon.id,
                          email: acc.email,
                        ),
                      );
                    });
                  },
                );
              });
            }
          },
          color: Colors.deepOrangeAccent,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              buildParticipationText(state),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
