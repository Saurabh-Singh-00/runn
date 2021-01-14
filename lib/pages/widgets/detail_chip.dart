import 'package:flutter/material.dart';

class DetailChip extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String data;

  const DetailChip({Key key, this.iconData, this.title, this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            color: Colors.deepOrangeAccent,
            size: 36.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$title",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "$data",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
