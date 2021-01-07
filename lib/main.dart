import 'package:flutter/material.dart';
import 'package:runn/injector/injector.dart';

void main() {
  injector.setup();
  runApp(Runn());
}

class Runn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Runn",
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
