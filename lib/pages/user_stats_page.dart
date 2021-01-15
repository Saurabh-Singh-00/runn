import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:runn/blocs/auth_bloc/auth_bloc.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/user_stats_by_marathon.dart';
import 'package:runn/pages/widgets/loading_list.dart';
import 'package:runn/pages/widgets/marathon_map_location.dart';
import 'package:runn/repositories/user_repository.dart';

class UserStatsPage extends StatelessWidget {
  final String marathonId;
  final String email;

  const UserStatsPage({Key key, this.marathonId, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User stats"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: FutureBuilder<Either<Exception, List<UserStatsByMarathon>>>(
        future: injector
            .get<UserRepository>()
            .fetchUserStatsByMarathon(marathonId, email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Either<Exception, List<UserStatsByMarathon>> either =
                  snapshot.data;
              return either.fold(
                (l) => Center(
                  child: Text("Something went wrong"),
                ),
                (r) => UserStatExpandableListView(
                  stats: r,
                ),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Oops Something went Wrong"),
              ),
            );
          }
          return LoadingList();
        },
      ),
    );
  }
}

class UserStatExpandableListView extends StatelessWidget {
  final List<UserStatsByMarathon> stats;

  const UserStatExpandableListView({Key key, this.stats}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stats.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final DateTime dateTime = DateTime.tryParse(stats[index].time);
        final String time = DateFormat.jms().format(dateTime);
        final String date = DateFormat.yMMMd().format(dateTime);
        return ExpansionTile(
          title: Text("$time"),
          subtitle: Text("$date"),
          leading: Icon(FontAwesomeIcons.stopwatch),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarathonMapLocation(
                lat: stats[index].lat,
                long: stats[index].long,
                pin: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.deepOrange,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: NetworkImage(
                          BlocProvider.of<AuthBloc>(context).account.photoUrl),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
