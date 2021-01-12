part of 'participation_bloc.dart';

@immutable
abstract class ParticipationState {}

class ParticipationInitial extends ParticipationState {}

class CheckingParticipation extends ParticipationState {}

class CheckingParticipationFailed extends ParticipationState {}

class Participating extends ParticipationState {}

class Participated extends ParticipationState {}

class ParticipationFailed extends ParticipationState {}
