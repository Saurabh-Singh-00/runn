import 'package:dartz/dartz.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/providers/marathon_provider.dart';

class MarathonRepository {
  final MarathonProvider marathonProvider;

  MarathonRepository({MarathonProvider marathonProvider})
      : this.marathonProvider = marathonProvider ?? MarathonProvider();

  Future<Either<Exception, List<Marathon>>> fetchMarathon({Map filter}) async {
    Either<Exception, List<Map>> either = await marathonProvider.fetchMarathon(filter: filter);
    return either.map((r) => r.map((e) => Marathon.fromJson(e)).toList());
  }
}
