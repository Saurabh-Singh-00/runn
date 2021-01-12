import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/runner.dart';
import 'package:runn/repositories/marathon_repository.dart';

part 'participation_event.dart';
part 'participation_state.dart';

class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  final MarathonRepository marathonRepository;
  ParticipationBloc({MarathonRepository marathonRepository})
      : this.marathonRepository =
            marathonRepository ?? injector.get<MarathonRepository>(),
        super(ParticipationInitial());

  Stream<ParticipationState> mapCheckParticipationToState(
      CheckParticipation event) async* {
    yield CheckingParticipation();
    Either<Exception, Runner> either = await marathonRepository.hasParticipated(
        event.marathonId, event.marathonCountry, event.userEmail);
    ParticipationState participationState = either.fold(
        (l) => CheckingParticipationFailed(), (r) => Participated());
    yield participationState;
  }

  Stream<ParticipationState> mapParticipateToState(Participate event) async* {
    yield Participating();
    Either<Exception, Runner> either =
        await marathonRepository.participate(event.runner);
    ParticipationState participationState =
        either.fold((l) => ParticipationFailed(), (r) => Participated());
    yield participationState;
  }

  @override
  Stream<ParticipationState> mapEventToState(
    ParticipationEvent event,
  ) async* {
    if (event is ResetParticipationCheck) {
      yield ParticipationInitial();
    } else if (event is CheckParticipation) {
      yield* mapCheckParticipationToState(event);
    } else if (event is Participate) {
      yield* mapParticipateToState(event);
    }
  }
}
