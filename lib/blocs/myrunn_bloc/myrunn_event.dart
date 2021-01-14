part of 'myrunn_bloc.dart';

@immutable
abstract class MyrunnEvent {}

class LoadMarathonsByRunner extends MyrunnEvent {
  final String userEmail;

  LoadMarathonsByRunner(this.userEmail);
}

class ResetRunns extends MyrunnEvent {}