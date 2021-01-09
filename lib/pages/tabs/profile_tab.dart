import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:runn/pages/tabs/tab.dart';
import 'package:runn/pages/widgets/stats_card.dart';

TabWidget profileTab = TabWidget(
  appBar: null,
  body: Builder(
    builder: (context) {
      return CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Container(
                    width: 156.0,
                    height: 156.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      'https://randomuser.me/api/portraits/women/11.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
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
              ],
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          )
        ],
      );
    },
  ),
  fab: null,
);
