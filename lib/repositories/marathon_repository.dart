import 'package:dartz/dartz.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/models/marathon_by_runner.dart';
import 'package:runn/models/marathon_by_sponsor.dart';
import 'package:runn/models/runner.dart';
import 'package:runn/models/user_stats_by_marathon.dart';
import 'package:runn/providers/marathon_provider.dart';

class MarathonRepository {
  final MarathonProvider marathonProvider;

  MarathonRepository({MarathonProvider marathonProvider})
      : this.marathonProvider = marathonProvider ?? MarathonProvider();

  Future<Either<Exception, List<Marathon>>> fetchMarathon({Map filter}) async {
    Either<Exception, List<Map>> either =
        await marathonProvider.fetchMarathon(filter: filter);
    return either.map((r) => r.map((e) => Marathon.fromJson(e)).toList());
  }

  Future<Either<Exception, Marathon>> fetchMarathonDetails(
      String id, String country,
      {Map filter}) async {
    Either<Exception, Map> either = await marathonProvider
        .fetchMarathonDetails(id, country, filter: filter);
    return either.map((r) => Marathon.fromJson(r));
  }

  Future<Either<Exception, List<Runner>>> fetchRunners(String marathonId,
      {Map filter}) async {
    Either<Exception, List<Map>> either =
        await marathonProvider.fetchRunners(marathonId, filter: filter);
    return either.map((r) => r.map((e) => Runner.fromJson(e)).toList());
  }

  Future<Either<Exception, Runner>> participate(Runner runner,
      {Map filter}) async {
    Either<Exception, Map> either = await marathonProvider
        .participate(runner.marathonId, runner.toJson(), filter: filter);
    return either.map((r) => Runner.fromJson(r));
  }

  Future<Either<Exception, List<MarathonByRunner>>> fetchMarathonsByRunner(
      {Map filter}) async {}

  Future<Either<Exception, List<MarathonBySponsor>>> fetchMarathonsBySponsor(
      String sponsorId,
      {Map filter}) async {
    Either<Exception, List<Map>> either = await marathonProvider
        .fetchMarathonBySponsor(sponsorId, filter: filter);
    return either
        .map((r) => r.map((e) => MarathonBySponsor.fromJson(e)).toList());
  }

  Future<Either<Exception, Runner>> hasParticipated(
      String marathonId, String marathonCountry, String email,
      {Map filter}) async {
    Either<Exception, Map> either = await marathonProvider
        .hasParticipated(marathonId, marathonCountry, email, filter: filter);
    return either.map((r) => Runner.fromJson(r));
  }

  Future<Either<Exception, List<MarathonByRunner>>> fetchMarathonByRunner(
      String userEmail,
      {Map filter}) async {
    Either<Exception, List<Map>> either =
        await marathonProvider.fetchMarathonByRunner(userEmail, filter: filter);
    return either
        .map((r) => r.map((e) => MarathonByRunner.fromJson(e)).toList());
  }

  Future<Either<Exception, UserStatsByMarathon>> checkParticipation(
      String marathonId, String email,
      {Map filter}) async {
    Either<Exception, Map> either = await marathonProvider
        .checkCompletion(marathonId, email, filter: filter);
    return either.map((r) => UserStatsByMarathon.fromJson(r));
  }
}
