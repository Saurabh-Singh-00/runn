import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/repositories/user_repository.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'race_event.dart';
part 'race_state.dart';

class RaceBloc extends Bloc<RaceEvent, RaceState> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();

  UserRepository userRepository = injector.get<UserRepository>();

  Position previousPosition;

  double distance = 0.0;
  String marathonId = "";
  String userEmail = "";

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

  Future<void> initPlatformState() async {
    stopWatchTimer.secondTime.listen(sendRaceData);
  }

  void sendRaceData(int seconds) async {
    if ((state.runtimeType == RaceStarted ||
            state.runtimeType == UpdatedDistance) &&
        seconds % 10 == 0) {
      Either<Exception, Position> position = await determinePosition();
      position.fold((l) {}, (r) {
        if (previousPosition != null && previousPosition != r) {
          distance += Geolocator.distanceBetween(previousPosition.latitude,
              previousPosition.longitude, r.latitude, r.longitude);
          userRepository.sendUserStatsByMarathon(
              marathonId, userEmail, r.latitude, r.longitude);
          add(UpdateDistance(distance));
          print(distance);
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
    yield RaceStarted(event.marathonId, event.email, 0.0);
    marathonId = event.marathonId;
    userEmail = event.email;
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  Stream<RaceState> mapStopRaceToState(EndRace event) async* {
    marathonId = "";
    userEmail = "";
    distance = 0.0;
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    yield RaceEnded(distance);
  }

  Stream<RaceState> mapUpdateDistanceToState(UpdateDistance event) async* {
    yield UpdatedDistance(event.distance);
  }

  @override
  Stream<RaceState> mapEventToState(
    RaceEvent event,
  ) async* {
    if (event is StartRace) {
      yield* mapStartRaceToState(event);
    } else if (event is EndRace) {
      yield* mapStopRaceToState(event);
    } else if (event is UpdateDistance) {
      yield* mapUpdateDistanceToState(event);
    }
  }
}
