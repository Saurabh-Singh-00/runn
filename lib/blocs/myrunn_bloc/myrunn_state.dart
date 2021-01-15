part of 'myrunn_bloc.dart';

@immutable
abstract class MyrunnState {}

class MyrunnInitial extends MyrunnState {}

class LoadingMarathonByRunner extends MyrunnState {}

class MarathonLoadedByRunner extends MyrunnState {
  final List<MarathonByRunner> marathons;

  MarathonLoadedByRunner(this.marathons);

  @override
  bool operator ==(other) {
    return (other is MarathonLoadedByRunner) &&
        (this.marathons.length == other.marathons.length);
  }
}

class MarathonLoadingFailedByRunner extends MyrunnState {
  final String message;

  MarathonLoadingFailedByRunner(this.message);
}
