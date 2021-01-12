part of 'participation_bloc.dart';

@immutable
abstract class ParticipationEvent {}

class CheckParticipation extends ParticipationEvent {
  final String marathonId;
  final String marathonCountry;
  final String userEmail;

  CheckParticipation(this.marathonId, this.marathonCountry, this.userEmail);
}

class CancelParticipationCheck extends ParticipationEvent {}

class Participate extends ParticipationEvent {
  final Runner runner;

  Participate(this.runner);
}

class ResetParticipationCheck extends ParticipationEvent {}
