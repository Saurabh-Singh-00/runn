import 'package:runn/helpers/helpers.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/providers/provider.dart';
import 'package:runn/services/api_service.dart';
import 'package:runn/services/rest_api_service.dart';

class MarathonProvider extends Provider {
  final String _urlAllMarathon = "/marathon";
  // Responsible for RAW Data from API
  final restAPI = injector.get<APIService>() as ReSTAPIService;

  Future<List<Map>> fetchMarathon({Map filter}) async {
    List<Map> res = [];
    Uri uri = constructUrlWithQueryParams(baseUrl, _urlAllMarathon, filter ?? {});
    res = await restAPI.get(uri) as List;
    return res;
  }
}