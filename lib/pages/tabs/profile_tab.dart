import 'package:flutter/material.dart';
import 'package:runn/pages/widgets/stats_card.dart';

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
          backgroundColor: Colors.black87,
        ),
        SliverGrid(
          delegate: SliverChildListDelegate(
            [
              StatsCard(
                title: "STEPS",
                data: "485",
              ),
              StatsCard(
                title: "DISTANCE",
                data: "0.3",
              ),
              StatsCard(
                title: "MARATHONS",
                data: "3",
              ),
            ],
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        )
      ],
    );
  }
}
