import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:runn/exceptions/api_exception.dart';
import 'package:runn/services/api_service.dart';

class ReSTAPIService implements APIService {
  @override
  Future<dynamic> delete(dynamic url, {Map<dynamic, dynamic> headers}) async {
    try {
      http.Response response = await http.delete(url, headers: headers);
      if ([200, 202, 204].contains(response.statusCode)) {
        return json.decode(response.body);
      } else {
        throw DeletionFailedException(
            "Oops! there seems to be no such record", response.statusCode);
      }
    } on SocketException catch (e) {
      rethrow;
    } on ResultNotFoundException catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> get(dynamic url,
      {Map<dynamic, dynamic> headers}) async {
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ResultNotFoundException(
            "Oops! Some Error occurred", response.statusCode);
      }
    } on SocketException catch (e) {
      rethrow;
    } on ResultNotFoundException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> retrieve(dynamic url, {Map<dynamic, dynamic> headers}) async {
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map;
      } else {
        throw ResultNotFoundException(
            "Oops! Some Error occurred", response.statusCode);
      }
    } on SocketException catch (e) {
      rethrow;
    } on ResultNotFoundException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> patch(dynamic url, Map<dynamic, dynamic> body,
      {Map<dynamic, dynamic> headers}) async {
    try {
      http.Response response =
          await http.put(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        return json.decode(response.body) as Map;
      } else {
        throw UpdateFailedException(
            "Oops! there seems to be no such record", response.statusCode);
      }
    } on SocketException catch (e) {
      rethrow;
    } on UpdateFailedException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> post(dynamic url, Map body,
      {Map<dynamic, dynamic> headers}) async {
    try {
      http.Response response =
          await http.post(url, body: json.encode(body), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 201) {
        return json.decode(response.body) as Map;
      } else {
        throw CreationFailedException(
            "Oops! there was some error.", response.statusCode);
      }
    } on SocketException catch (e) {
      rethrow;
    } on CreationFailedException catch (e) {
      rethrow;
    }
  }
}
