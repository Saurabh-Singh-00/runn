part of 'marathon_bloc.dart';

@immutable
abstract class MarathonEvent {}

class LoadMarathon extends MarathonEvent {
  final Map filter;

  LoadMarathon(Map filter) : this.filter = filter ?? {};
}

class LoadedMarathon extends MarathonEvent {}
