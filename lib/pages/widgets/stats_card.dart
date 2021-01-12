import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String data;
  final Widget iconData;
  final Color color;

  const StatsCard({
    Key key,
    this.title,
    this.data,
    this.iconData,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: iconData,
                  ),
                  Flexible(
                    child: Text(
                      "$title",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.anton(
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text("$data",
                    maxLines: 1,
                    style: GoogleFonts.anton(
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.black))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
