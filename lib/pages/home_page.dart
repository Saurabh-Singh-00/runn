import 'dart:async';

import 'package:flutter/material.dart';
import 'package:runn/pages/tabs/tab.dart';
import 'package:runn/pages/tabs/tabs.dart';

class HomePage extends StatelessWidget {
  final StreamController<int> tabIndexStream = StreamController<int>.broadcast()
    ..add(0);

  final List<TabWidget> tabs = [
    exploreTab,
    statsTab,
    profileTab,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: tabs.length,
        child: Builder(builder: (context) {
          TabController tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: tabs[tabController.index].appBar,
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: tabs.map((tab) => tab.body).toList(),
            ),
            floatingActionButton: tabs[tabController.index].fab ?? Container(),
            bottomNavigationBar: StreamBuilder<int>(
              stream: tabIndexStream.stream,
              initialData: 0,
              builder: (context, snapshot) {
                return BottomNavigationBar(
                  onTap: (index) {
                    tabIndexStream.add(index);
                    tabController.animateTo(index);
                  },
                  currentIndex: snapshot.data ?? 0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore),
                      label: "Explore",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart_rounded),
                      label: "Stats",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: "Profile",
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
