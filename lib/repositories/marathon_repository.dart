import 'package:dartz/dartz.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/models/marathon_by_runner.dart';
import 'package:runn/models/marathon_by_sponsor.dart';
import 'package:runn/models/runner.dart';
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
      {Map filter}) async {}

  Future<Either<Exception, List<Runner>>> fetchRunners(String marathonId,
      {Map filter}) async {
    Either<Exception, List<Map>> either =
        await marathonProvider.fetchRunners(marathonId, filter: filter);
    return either.map((r) => r.map((e) => Runner.fromJson(e)).toList());
  }

  Future<Either<Exception, MarathonByRunner>> participate({Map filter}) async {}

  Future<Either<Exception, List<MarathonByRunner>>> fetchMarathonsByRunner(
      {Map filter}) async {}

  Future<Either<Exception, List<MarathonBySponsor>>> fetchMarathonsBySponsor(
      {Map filter}) async {}

  Future<Either<Exception, bool>> hasParticipated({Map filter}) async {}
}
