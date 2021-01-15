part of 'race_bloc.dart';

@immutable
abstract class RaceEvent {}

class LoadRace extends RaceEvent {}

class StartRace extends RaceEvent {
  final String marathonId;
  final String email;

  StartRace(this.marathonId, this.email);
}

class UpdateDistance extends RaceEvent {
  final double distance;

  UpdateDistance(this.distance);
}

class PauseRace extends RaceEvent {}

class ResumeRace extends RaceEvent {}

class EndRace extends RaceEvent {}
