import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';

class MarathonMapLocation extends StatelessWidget {
  final double lat, long;
  final Widget pin;
  const MarathonMapLocation({
    Key key,
    this.lat,
    this.long,
    this.pin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(lat ?? 51.5, long ?? -0.09),
          zoom: 14.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 48.0,
                height: 48.0,
                point: LatLng(lat ?? 51.5, long ?? -0.09),
                builder: (ctx) => Container(
                  child: pin ??
                      Icon(
                        FontAwesomeIcons.mapPin,
                        color: Colors.deepOrangeAccent,
                        size: 44.0,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
