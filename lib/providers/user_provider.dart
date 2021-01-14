import 'package:dartz/dartz.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/user_stats_by_marathon.dart';
import 'package:runn/providers/base_data_provider.dart';
import 'package:runn/services/api_service.dart';
import 'package:runn/services/rest_api_service.dart';

class UserProvider extends BaseDataProvider {
  final String _urlAllUser = "api/v1/user";
  final String _urlUserDetail = "detail";
  final String _urlUserStats = "stats";

  final restAPI = injector.get<APIService>() as ReSTAPIService;

  Future<Either<Exception, Map>> fetchUserDetails(String email,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllUser, _urlUserDetail, email], filter ?? Map());
    Either<Exception, Map> either = await Task(() => restAPI.retrieve(uri))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, Map>> fetchUserStats(String email,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllUser, _urlUserStats, email], filter ?? Map());
    Either<Exception, Map> either = await Task(() => restAPI.retrieve(uri))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, Map>> sendUserStatsByMarathon(
      String marathonId, String email, double lat, double long,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(baseUrl,
        [_urlAllUser, _urlUserStats, marathonId, email], filter ?? Map());
    Either<Exception, Map> either = await Task(() => restAPI.post(
            uri,
            UserStatsByMarathon(
              marathonId: marathonId,
              email: email,
              lat: lat,
              long: long,
              time: null,
            ).toJson()))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }
}
