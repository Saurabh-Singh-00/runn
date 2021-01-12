import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/runner.dart';
import 'package:runn/repositories/marathon_repository.dart';

part 'runner_event.dart';
part 'runner_state.dart';

class RunnerBloc extends Bloc<RunnerEvent, RunnerState> {
  RunnerBloc() : super(RunnerInitial());

  Stream<RunnerState> mapRunnersLoadingToState(LoadRunners event) async* {
    yield LoadingRunners();
    Either<Exception, List<Runner>> either =
        await injector.get<MarathonRepository>().fetchRunners(event.marathonId);
    RunnerState runnerState = either.fold(
        (l) => RunnersLoadingFailed("Oops! there was some error"),
        (r) => RunnersLoaded(r));
    yield runnerState;
  }

  @override
  Stream<RunnerState> mapEventToState(
    RunnerEvent event,
  ) async* {
    if (event is LoadRunners) {
      yield* mapRunnersLoadingToState(event);
    }
  }
}
