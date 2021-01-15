part of 'race_bloc.dart';

@immutable
abstract class RaceState {}

class RaceInitial extends RaceState {}

class LoadingRace extends RaceState {}

class RaceLoaded extends RaceEvent {}

class RaceStarted extends RaceState {
  final String marathonId;
  final String email;
  final double distance;

  RaceStarted(this.marathonId, this.email, this.distance);
}

class RacePaused extends RaceState {}

class UpdatedDistance extends RaceState {
  final double distance;

  UpdatedDistance(this.distance);
}

class RaceEnded extends RaceState {
  final double distance;
  RaceEnded(this.distance);
}
