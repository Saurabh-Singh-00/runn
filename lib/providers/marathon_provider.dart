import 'package:dartz/dartz.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/providers/base_data_provider.dart';
import 'package:runn/services/api_service.dart';
import 'package:runn/services/rest_api_service.dart';

// Responsible for RAW Data from API
class MarathonProvider extends BaseDataProvider {
  final String _urlAllMarathon = "/api/v1/marathon";
  final restAPI = injector.get<APIService>() as ReSTAPIService;

  Future<Either<Exception, List<Map>>> fetchMarathon({Map filter}) async {
    Uri uri =
        constructUrlWithQueryParams(baseUrl, _urlAllMarathon, filter ?? Map());
    Either<Exception, List<Map>> either = await Task(() => restAPI.get(uri))
        .attempt()
        .map((a) => a.map((r) => r.map((e) => (e as Map)).toList()))
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }
}
