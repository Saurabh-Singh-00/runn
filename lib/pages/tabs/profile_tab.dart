import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn/blocs/auth_bloc/auth_bloc.dart';
import 'dart:math';

import 'package:runn/pages/pages.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () async {
                    authBloc.add(SignOut());
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => SignInPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
              backgroundColor: Colors.black87,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: CircleAvatar(
                            radius: 64.0,
                            backgroundImage: NetworkImage(
                              (state is Authenticated)
                                  ? state.account.photoUrl
                                  : 'https://randomuser.me/api/portraits/women/11.jpg',
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  (state is Authenticated)
                                      ? state.account.displayName
                                      : 'https://randomuser.me/api/portraits/women/11.jpg',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  (state is Authenticated)
                                      ? state.account.email
                                      : 'https://randomuser.me/api/portraits/women/11.jpg',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  StatsTile(
                    data: "4002",
                    category: "STEPS",
                    icon: FontAwesomeIcons.shoePrints,
                    color: Colors.green,
                  ),
                  StatsTile(
                    data: "2 KM",
                    category: "DISTANCE",
                    icon: FontAwesomeIcons.road,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class StatsTile extends StatelessWidget {
  final String data;
  final String category;
  final IconData icon;
  final Color color;
  const StatsTile({
    Key key,
    this.data,
    this.category,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          title: Text("$data"),
          tileColor: Colors.white,
          subtitle: Text("$category"),
          leading: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
