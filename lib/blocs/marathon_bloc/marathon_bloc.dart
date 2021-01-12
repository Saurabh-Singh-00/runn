import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/marathon.dart';
import 'package:runn/models/marathon_by_runner.dart';
import 'package:runn/repositories/marathon_repository.dart';

part 'marathon_event.dart';

part 'marathon_state.dart';

class MarathonBloc extends Bloc<MarathonEvent, MarathonState> {
  final MarathonRepository marathonRepository;

  MarathonBloc({MarathonRepository marathonRepository})
      : this.marathonRepository =
            marathonRepository ?? injector.get<MarathonRepository>(),
        super(MarathonInitial());

  Stream<MarathonState> mapMarathonLoadingToState(LoadMarathon event) async* {
    yield LoadingMarathon();
    Either<Exception, List<Marathon>> either =
        await marathonRepository.fetchMarathon(filter: event.filter);
    MarathonState marathonState = either.fold(
        (l) => MarathonLoadingFailed("Oops! there was some error"),
        (r) => MarathonLoaded(r));
    yield marathonState;
  }

  @override
  Stream<MarathonState> mapEventToState(
    MarathonEvent event,
  ) async* {
    if (event is LoadMarathon) {
      yield* mapMarathonLoadingToState(event);
    }
  }
}
