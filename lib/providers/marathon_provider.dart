import 'package:dartz/dartz.dart';
import 'package:runn/helpers/helpers.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/providers/base_data_provider.dart';
import 'package:runn/services/api_service.dart';
import 'package:runn/services/rest_api_service.dart';

// Responsible for RAW Data from API
class MarathonProvider extends BaseDataProvider {
  final String _urlAllMarathon = "api/v1/marathon";
  final String _urlAllRunners = "runner";
  final String _urlSponsor = "sponsor";

  final restAPI = injector.get<APIService>() as ReSTAPIService;

  Future<Either<Exception, List<Map>>> fetchMarathon({Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllMarathon], filter ?? Map());
    Either<Exception, List<Map>> either = await Task(() => restAPI.get(uri))
        .attempt()
        .map((a) => a.map((r) => r.map((e) => (e as Map)).toList()))
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, Map>> fetchMarathonDetails(String id, String country,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllMarathon, country, id, 'detail'], filter ?? Map());
    Either<Exception, Map> either = await Task(() => restAPI.retrieve(uri))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, List<Map>>> fetchRunners(String marathonId,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllMarathon, marathonId, _urlAllRunners], filter);
    Either<Exception, List<Map>> either = await Task(() => restAPI.get(uri))
        .attempt()
        .map((a) => a.map((r) => r.map((e) => (e as Map)).toList()))
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, Map>> hasParticipated(
      String marathonId, String marathonCountry, String email,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl,
        [_urlAllMarathon, marathonId, marathonCountry, email, _urlAllRunners],
        filter);
    Either<Exception, Map> either = await Task(() => restAPI.retrieve(uri))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, Map>> participate(String marathonId, Map body,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllMarathon, marathonId, 'participate'], filter);
    Either<Exception, Map> either = await Task(() => restAPI.post(uri, body))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, List<Map>>> fetchMarathonByRunner(String userEmail,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllMarathon, _urlAllRunners, userEmail], filter);
    Either<Exception, List<Map>> either = await Task(() => restAPI.get(uri))
        .attempt()
        .map((a) => a.map((r) => r.map((e) => (e as Map)).toList()))
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, List<Map>>> fetchMarathonBySponsor(String sponsorId,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(
        baseUrl, [_urlAllMarathon, _urlSponsor, sponsorId], filter);
    Either<Exception, List<Map>> either = await Task(() => restAPI.get(uri))
        .attempt()
        .map((a) => a.map((r) => r.map((e) => (e as Map)).toList()))
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }

  Future<Either<Exception, Map>> checkCompletion(
      String marathonId, String email,
      {Map filter}) async {
    Uri uri = constructUrlWithQueryParams(baseUrl,
        ['api/v1/user', 'stats', marathonId, email, 'complete'], filter);
    Either<Exception, Map> either = await Task(() => restAPI.retrieve(uri))
        .attempt()
        .map((a) => a.leftMap((l) => (l as Exception)))
        .run();
    return either;
  }
}
