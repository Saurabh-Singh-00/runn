import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/pages/widgets/loading_list.dart';

class MyRunnsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.black87,
            pinned: true,
            title: Text("My Runns"),
            leading: Icon(FontAwesomeIcons.running),
          )
        ];
      },
      body: BlocBuilder<MyrunnBloc, MyrunnState>(
        cubit: BlocProvider.of<MyrunnBloc>(context),
        builder: (context, state) {
          if (state is MarathonLoadingFailedByRunner) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.black),
              ),
            );
          } else if (state is MarathonLoadedByRunner) {
            if (state.marathons.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Looks like you are yet to start your journey"),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.marathons.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text("${state.marathons[index].title}"),
                      tileColor: Colors.white,
                      subtitle: Text(
                          "${state.marathons[index].country.toUpperCase()}"),
                      leading: CircleAvatar(
                        child:
                            Text("${state.marathons[index].distance.toInt()}"),
                      ),
                      trailing: IconButton(
                          icon: Icon(FontAwesomeIcons.arrowAltCircleRight),
                          onPressed: () {}),
                    ),
                  ),
                );
              },
            );
          }
          return LoadingList();
        },
      ),
    );
  }
}
