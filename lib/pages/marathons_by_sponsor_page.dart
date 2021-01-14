import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/models/marathon_by_sponsor.dart';
import 'package:runn/pages/marathon_detail_page.dart';
import 'package:runn/pages/widgets/loading_list.dart';
import 'package:runn/repositories/marathon_repository.dart';

class MarathonsBySponsorPage extends StatelessWidget {
  final SponsorType sponsorType;

  const MarathonsBySponsorPage({Key key, this.sponsorType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marathons"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: FutureBuilder<Either<Exception, List<MarathonBySponsor>>>(
        future: injector
            .get<MarathonRepository>()
            .fetchMarathonsBySponsor(sponsorType.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Either<Exception, List<MarathonBySponsor>> either = snapshot.data;
              return either.fold(
                (l) => Center(
                  child: Text("Something went wrong"),
                ),
                (r) => MarathonSponsorsListView(
                  marathons: r,
                ),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Oops Something went Wrong"),
              ),
            );
          }
          return LoadingList();
        },
      ),
    );
  }
}

class MarathonSponsorsListView extends StatelessWidget {
  final List<MarathonBySponsor> marathons;

  const MarathonSponsorsListView({Key key, this.marathons}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: marathons.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text("${marathons[index].title}"),
              tileColor: Colors.white,
              subtitle: Text("${marathons[index].country.toUpperCase()}"),
              leading: CircleAvatar(
                child: Text("${marathons[index].distance.toInt()}"),
              ),
              trailing: IconButton(
                icon: Icon(FontAwesomeIcons.arrowAltCircleRight),
                onPressed: () async {
                  AlertDialog alert(String title, {Widget display}) =>
                      AlertDialog(
                        content: new Row(
                          children: [
                            display ?? CircularProgressIndicator(),
                            Container(
                                margin: EdgeInsets.only(left: 16.0),
                                child: Text("$title")),
                          ],
                        ),
                      );
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert("Loading");
                    },
                  );
                  MarathonRepository repository =
                      injector.get<MarathonRepository>();
                  Either<Exception, Marathon> either =
                      await repository.fetchMarathonDetails(
                    marathons[index].id,
                    marathons[index].country,
                  );
                  either.fold((l) {
                    Navigator.of(context).pop();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return alert("Error occured!",
                            display: Icon(FontAwesomeIcons.cross));
                      },
                    );
                  }, (r) {
                    pushReplacementRoute(
                        context,
                        MarathonDetailPage(
                          marathon: r,
                        ));
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
