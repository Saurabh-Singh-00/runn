import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:intl/intl.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/models/runner.dart';
import 'package:runn/pages/race_page.dart';
import 'package:runn/pages/runners_page.dart';

class MarathonDetailPage extends StatelessWidget {
  final Marathon marathon;

  const MarathonDetailPage({Key key, this.marathon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.tryParse(marathon.dateTime);
    final String marathonDate = DateFormat.yMMMd().format(dateTime);
    final String marathonTime = DateFormat.jm().format(dateTime);
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ParticipationBloc>(context)
            .add(ResetParticipationCheck());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.215,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  pinned: true,
                  title: Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      "${marathon.title}",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: FlexibleSpaceBarBackground(),
                  ),
                )
              ];
            },
            body: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              children: [
                Card(
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
                            title: "Date",
                            data: "$marathonDate",
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: DetailChip(
                            iconData: FontAwesomeIcons.stopwatch,
                            title: "Time",
                            data: "$marathonTime",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
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
                            iconData: FontAwesomeIcons.road,
                            title: "Distance",
                            data: "${marathon.distance} KM",
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<RunnerBloc>(context)
                                  .add(LoadRunners(marathon.id));
                              pushRoute(context, RunnersPage());
                            },
                            child: DetailChip(
                              iconData: FontAwesomeIcons.running,
                              title: "Runners",
                              data: "View Runners",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: MarathonMapLocation(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ParticipateButton(
                    marathon: marathon,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Sponsors",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 78.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: marathon.sponsors.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: SponsorImageContainer(),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "${marathon.description}",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlexibleSpaceBarBackground extends StatelessWidget {
  const FlexibleSpaceBarBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.network(
            'https://av.sc.com/corp-en/content/images/Jersey_marathon_runners_town_shot.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.25),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.65),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MarathonMapLocation extends StatelessWidget {
  const MarathonMapLocation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 48.0,
                height: 48.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: Icon(
                    FontAwesomeIcons.mapPin,
                    color: Colors.deepOrangeAccent,
                    size: 44.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SponsorImageContainer extends StatelessWidget {
  final SponsorType sponsorType;

  const SponsorImageContainer({
    Key key,
    this.sponsorType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          'http://scanpapyrus.com/images/logos/samsung-logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

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
      return "Start Runn";
    if (state is Participated) return "Already In";
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
          onPressed: () {
            if (state is CheckingParticipationFailed ||
                state is ParticipationFailed) {
              if (dateTime.isAfter(now)) {
                participate(participationBloc, acc);
                BlocProvider.of<MyrunnBloc>(context)
                    .add(LoadMarathonsByRunner(acc.email));
              }
            } else if (state is Participated && dateTime.isAfter(now)) {
              // Start Runn
              BlocProvider.of<RaceBloc>(context).add(LoadRace());
              pushRoute(
                  context,
                  RacePage(
                    marathon: marathon,
                  ));
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

class DetailChip extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String data;

  const DetailChip({Key key, this.iconData, this.title, this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            color: Colors.deepOrangeAccent,
            size: 36.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$title",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "$data",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
