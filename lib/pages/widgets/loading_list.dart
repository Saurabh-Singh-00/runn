import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final int itemCount;
  const LoadingList({
    Key key,
    this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount ?? 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: MediaQuery.of(context).size.height * 0.225,
            ),
          ),
          baseColor: Colors.black38,
          highlightColor: Colors.white30,
        );
      },
    );
  }
}
