part of 'runner_bloc.dart';

@immutable
abstract class RunnerState {}

class RunnerInitial extends RunnerState {}

class LoadingRunners extends RunnerState {}

class RunnersLoaded extends RunnerState {
  final List<Runner> runners;

  RunnersLoaded(this.runners);
}

class RunnersLoadingFailed extends RunnerState {
  final String message;

  RunnersLoadingFailed(this.message);
}
