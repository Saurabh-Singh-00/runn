import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:runn/exceptions/api_exception.dart';
import 'package:runn/services/api_service.dart';

class ReSTAPIService implements APIService {
  @override
  Future delete(Uri url, {Map<dynamic, dynamic> headers}) async {
    await Future.delayed(Duration(seconds: 1));
    return ;
  }

  @override
  Future get(Uri url, {Map<dynamic, dynamic> headers}) async {
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ResultNotFoundException("Oops! there seems to be no such record");
      }
    } on SocketException catch(e) {
      throw SocketException("Please check your Internet");
    } on ResultNotFoundException catch(e) {
      return {
        'error': e.message
      };
    } catch(e) {
      return {
        'error': e.toString()
      };
    }
  }

  @override
  Future patch(Uri url, Map<dynamic, dynamic> body, {Map<dynamic, dynamic> headers}) async {
    await Future.delayed(Duration(seconds: 1));
    return ;
  }

  @override
  Future post(Uri url, Map<dynamic, dynamic> body, {Map<dynamic, dynamic> headers}) async {
    await Future.delayed(Duration(seconds: 1));
    return ;
  }

}