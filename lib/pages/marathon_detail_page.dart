import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/pages/marathons_by_sponsor_page.dart';
import 'package:runn/pages/runners_page.dart';
import 'package:runn/pages/widgets/detail_chip.dart';
import 'package:runn/pages/widgets/marathon_map_location.dart';
import 'package:runn/pages/widgets/participation_button.dart';

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
                            title: "End Date",
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
                          child: SponsorImageContainer(
                            sponsorType: marathon.sponsors[index],
                          ),
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

class SponsorImageContainer extends StatelessWidget {
  final SponsorType sponsorType;

  const SponsorImageContainer({
    Key key,
    this.sponsorType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushRoute(
          context,
          MarathonsBySponsorPage(
            sponsorType: sponsorType,
          ),
        );
      },
      child: Container(
        width: 78.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            sponsorType.logo ??
                'http://scanpapyrus.com/images/logos/samsung-logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
