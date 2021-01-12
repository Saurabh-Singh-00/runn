import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Uri constructUrlWithQueryParams(
    String baseUrl, List<String> path, Map<dynamic, dynamic> queryParams) {
  Uri uri;
  String extendedPath = "/" + path.join("/");
  if (queryParams == null || queryParams.isEmpty) {
    uri = Uri.http(baseUrl, extendedPath);
  } else {
    uri = Uri.http(baseUrl, extendedPath, queryParams);
  }
  return uri;
}

Future<T> pushRoute<T>(BuildContext context, Widget page) async {
  return await Navigator.of(context)
      .push<T>(MaterialPageRoute(builder: (_) => page));
}

Future<T> pushReplacementRoute<T, TO>(BuildContext context, Widget page) async {
  return await Navigator.of(context)
      .pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
}
