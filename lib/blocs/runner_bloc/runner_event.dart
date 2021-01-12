part of 'runner_bloc.dart';

@immutable
abstract class RunnerEvent {}

class LoadRunners extends RunnerEvent {
  final String marathonId;

  LoadRunners(this.marathonId);
}
