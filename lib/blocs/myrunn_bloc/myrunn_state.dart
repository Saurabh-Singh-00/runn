part of 'myrunn_bloc.dart';

@immutable
abstract class MyrunnState {}

class MyrunnInitial extends MyrunnState {}

class LoadingMarathonByRunner extends MyrunnState {}

class MarathonLoadedByRunner extends MyrunnState {
  final List<MarathonByRunner> marathons;

  MarathonLoadedByRunner(this.marathons);
}

class MarathonLoadingFailedByRunner extends MyrunnState {
  final String message;

  MarathonLoadingFailedByRunner(this.message);
}
