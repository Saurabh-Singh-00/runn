import 'package:flutter/material.dart';

class FlexibleAppBar extends StatelessWidget {
  const FlexibleAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(backgroundColor: Colors.white, radius: 26.0),
              ],
            ),
          ),
          Text(
            "Hello Saurabh",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
              color: Colors.white,
            ),
          ),
          Text(
            "Discover marathons near by.",
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline4.fontSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
