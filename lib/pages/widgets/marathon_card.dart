import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/pages/marathon_detail_page.dart';

class MarathonCard extends StatelessWidget {
  final Marathon marathon;

  const MarathonCard({
    Key key,
    this.marathon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.tryParse(marathon.dateTime);
    final String marathonDate = DateFormat.yMMMd().format(dateTime);

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          pushRoute(
              context,
              MarathonDetailPage(
                marathon: marathon,
              ));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.network(
                'https://av.sc.com/corp-en/content/images/Jersey_marathon_runners_town_shot.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black12,
                      Colors.black87,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${marathon.distance}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "KM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 16.0,
              left: 16.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "$marathonDate",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      marathon.title,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      marathon.country,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
