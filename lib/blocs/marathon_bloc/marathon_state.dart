part of 'marathon_bloc.dart';

@immutable
abstract class MarathonState {}

class MarathonInitial extends MarathonState {}

class LoadingMarathon extends MarathonState {}

class MarathonLoaded extends MarathonState {
  final List<Marathon> marathons;

  MarathonLoaded(this.marathons);
}

class MarathonLoadingFailed extends MarathonState {
  final String message;

  MarathonLoadingFailed(this.message);
}
