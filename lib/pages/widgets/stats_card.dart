import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String data;

  const StatsCard({
    Key key,
    this.title,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text("$title",
            textAlign: TextAlign.center,
            style: GoogleFonts.anton(
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, letterSpacing: 2))),
      ),
      child: Card(
        elevation: .0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.black87,
        child: Center(
          child: Text("$data",
              maxLines: 1,
              style: GoogleFonts.anton(
                  textStyle: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.orangeAccent))),
        ),
      ),
    );
  }
}
