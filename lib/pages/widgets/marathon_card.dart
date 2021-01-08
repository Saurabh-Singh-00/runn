import 'package:flutter/material.dart';
import 'package:runn/models/marathon.dart';

class MarathonCard extends StatelessWidget {
  final Marathon marathon;

  const MarathonCard({
    Key key,
    this.marathon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.225,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            bottom: 8.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    marathon.title,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5.fontSize,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    marathon.country,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
