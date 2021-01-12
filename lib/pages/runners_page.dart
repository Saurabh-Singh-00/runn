import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/blocs/runner_bloc/runner_bloc.dart';
import 'package:runn/pages/widgets/loading_list.dart';

class RunnersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Runners"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: BlocBuilder<RunnerBloc, RunnerState>(
        builder: (context, state) {
          if (state is RunnersLoadingFailed) {
            return Center(
              child: Text("${state.message}"),
            );
          } else if (state is RunnersLoaded) {
            if (state.runners.isEmpty) {
              return Center(
                child: Text("Be the first one to join!"),
              );
            }
            return GridView.builder(
              itemCount: state.runners.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CircleAvatar(
                            radius: 56.0,
                            backgroundColor: Colors.deepOrangeAccent,
                            child: Text(
                              "${state.runners[index].name[0].toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 42.0, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text(
                            "${state.runners[index].name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
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
