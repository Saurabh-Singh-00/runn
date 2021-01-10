import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:runn/models/marathon.dart';

class MarathonDetailPage extends StatelessWidget {
  final Marathon marathon;

  const MarathonDetailPage({Key key, this.marathon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.tryParse(marathon.dateTime);
    final String marathonDate = DateFormat.yMMMd().format(dateTime);
    final String marathonTime = DateFormat.jm().format(dateTime);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                backgroundColor: Colors.white,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
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
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.25),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.65),
                                Theme.of(context).scaffoldBackgroundColor,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 18.0),
                      child: Icon(
                        FontAwesomeIcons.running,
                        color: Colors.deepOrangeAccent,
                        size: 36.0,
                      ),
                    ),
                    Text(
                      "${marathon.title}",
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
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
                        child: DetailChip(
                          iconData: FontAwesomeIcons.mapPin,
                          title: "Location",
                          data: "Open maps",
                        ),
                      ),
                    ],
                  ),
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
                              'http://scanpapyrus.com/images/logos/samsung-logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
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
        floatingActionButton: RaisedButton(
          onPressed: () {},
          color: Colors.deepOrangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              "Participate",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
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
