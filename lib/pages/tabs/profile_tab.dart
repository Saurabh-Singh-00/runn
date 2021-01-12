import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn/pages/widgets/stats_card.dart';
import 'dart:math';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Text(
            "Your Stats",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          primary: true,
          leading: Icon(FontAwesomeIcons.chartLine),
          backgroundColor: Colors.black87,
        ),
        SliverGrid(
          delegate: SliverChildListDelegate(
            [
              StatsCard(
                title: "STEPS",
                data: "485",
                iconData: Transform.rotate(
                  angle: -pi / 2,
                  child: Icon(
                    FontAwesomeIcons.shoePrints,
                    color: Colors.red,
                  ),
                ),
                color: Colors.red,
              ),
              StatsCard(
                title: "DISTANCE",
                data: "0.3",
                iconData: Icon(
                  FontAwesomeIcons.road,
                  color: Colors.green,
                ),
                color: Colors.green,
              ),
              StatsCard(
                title: "MARATHONS",
                data: "3",
                iconData: Icon(
                  FontAwesomeIcons.running,
                  color: Colors.blue,
                ),
                color: Colors.blue,
              ),
            ],
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        )
      ],
    );
  }
}
