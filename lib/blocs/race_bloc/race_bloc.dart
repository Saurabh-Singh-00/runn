import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:pedometer/pedometer.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/repositories/user_repository.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'race_event.dart';
part 'race_state.dart';

class RaceBloc extends Bloc<RaceEvent, RaceState> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();

  Stream<StepCount> stepCountStream = Pedometer.stepCountStream;

  Stream<PedestrianStatus> pedestrianStatusStream =
      Pedometer.pedestrianStatusStream;

  UserRepository userRepository = injector.get<UserRepository>();

  Position previousPosition;

  RaceBloc() : super(RaceInitial()) {
    initPlatformState();
  }

  Future<Either<Exception, Position>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Either<Exception, Position> either =
        await Task(Geolocator.getCurrentPosition)
            .attempt()
            .map((a) => a.leftMap((l) => (l as Exception)))
            .run();

    return either;
  }

  void onStepCount(StepCount event) {
    int steps = event.steps;
    DateTime timeStamp = event.timeStamp;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    String status = event.status;
    DateTime timeStamp = event.timeStamp;
    if (!(state is RaceInitial)) {
      if (event.status == 'walking') {}
    }
  }

  void onPedestrianStatusError(error) {}

  void onStepCountError(error) {}

  Future<void> initPlatformState() async {
    stepCountStream.listen(onStepCount).onError(onStepCountError);

    pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    stopWatchTimer.secondTime.listen(sendRaceData);
  }

  void sendRaceData(int seconds) async {
    if (state is RaceStarted && seconds % 10 == 0) {
      Either<Exception, Position> position = await determinePosition();
      position.fold((l) {}, (r) {
        if (previousPosition != null && previousPosition != r) {
          userRepository.sendUserStatsByMarathon(
              (state as RaceStarted).marathonId,
              (state as RaceStarted).email,
              r.latitude,
              r.longitude);
        }
        previousPosition = r;
      });
    }
  }

  @override
  Future<void> close() {
    stopWatchTimer.dispose();
    return super.close();
  }

  Stream<RaceState> mapStartRaceToState(StartRace event) async* {
    yield RaceStarted(event.marathonId, event.email);
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  Stream<RaceState> mapStopRaceToState(EndRace event) async* {
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    yield RaceEnded();
  }

  @override
  Stream<RaceState> mapEventToState(
    RaceEvent event,
  ) async* {
    if (event is StartRace) {
      yield* mapStartRaceToState(event);
    } else if (event is EndRace) {
      yield* mapStopRaceToState(event);
    }
  }
}
