import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn/pages/tabs/tabs.dart';

class HomePage extends StatelessWidget {
  final StreamController<int> tabIndexStream = StreamController<int>.broadcast()
    ..add(0);

  final List<Widget> tabs = [ExploreTab(), MyRunnsTab()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: tabs.length,
        child: Builder(builder: (context) {
          TabController tabController = DefaultTabController.of(context);
          return Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: tabs,
            ),
            bottomNavigationBar: StreamBuilder<int>(
              stream: tabIndexStream.stream,
              initialData: 0,
              builder: (context, snapshot) {
                return BottomNavigationBar(
                  backgroundColor: Colors.black,
                  selectedIconTheme:
                      IconThemeData(color: Colors.deepOrangeAccent),
                  unselectedIconTheme: IconThemeData(color: Colors.white60),
                  unselectedLabelStyle: TextStyle(color: Colors.white60),
                  unselectedItemColor: Colors.white60,
                  selectedItemColor: Colors.deepOrangeAccent,
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
                      icon: Icon(FontAwesomeIcons.running),
                      label: "My Runns",
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
