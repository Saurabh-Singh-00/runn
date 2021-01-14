part of 'race_bloc.dart';

@immutable
abstract class RaceState {}

class RaceInitial extends RaceState {}

class LoadingRace extends RaceState {}

class RaceLoaded extends RaceEvent {}

class RaceStarted extends RaceState {
  final String marathonId;
  final String email;

  RaceStarted(this.marathonId, this.email);
}

class RacePaused extends RaceState {}

class RaceEnded extends RaceState {}
