import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/pages/widgets/flexible_app_bar.dart';
import 'package:runn/pages/widgets/loading_list.dart';
import 'package:runn/pages/widgets/marathon_card.dart';

class ExploreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.325,
            backgroundColor: Colors.black87,
            flexibleSpace: FlexibleSpaceBar(
              background: FlexibleAppBar(),
            ),
          )
        ];
      },
      body: BlocBuilder<MarathonBloc, MarathonState>(
        builder: (context, state) {
          if (state is MarathonLoadingFailed) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.black),
              ),
            );
          } else if (state is MarathonLoaded) {
            if (state.marathons.isEmpty) {
              return Center(
                child: Text("No marathons Nearby"),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                if (state is MarathonLoaded || state is MarathonLoadingFailed) {
                  BlocProvider.of<MarathonBloc>(context).add(LoadMarathon({}));
                }
              },
              child: ListView.builder(
                itemCount: state.marathons.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: MarathonCard(
                      marathon: state.marathons[index],
                    ),
                  );
                },
              ),
            );
          }
          return LoadingList();
        },
      ),
    );
  }
}
