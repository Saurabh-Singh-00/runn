import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:runn/blocs/blocs.dart';
import 'package:runn/injector/injector.dart';
import 'package:runn/models/marathon_by_runner.dart';
import 'package:runn/repositories/marathon_repository.dart';

part 'myrunn_event.dart';
part 'myrunn_state.dart';

class MyrunnBloc extends Bloc<MyrunnEvent, MyrunnState> {
  final MarathonRepository marathonRepository;
  StreamSubscription subscription;
  final AuthBloc authBloc;
  MyrunnBloc(this.authBloc, {MarathonRepository marathonRepository})
      : this.marathonRepository =
            marathonRepository ?? injector.get<MarathonRepository>(),
        super(MyrunnInitial()) {
    subscription = authBloc.listen((authState) => myRunnListener(authState));
  }

  void myRunnListener(AuthState state) {
    print(state);
    if (state is Authenticated) {
      this.add(LoadMarathonsByRunner(state.account.email));
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  Stream<MyrunnState> mapMarathonLoadingByRunnerToState(
      LoadMarathonsByRunner event) async* {
    yield LoadingMarathonByRunner();
    Either<Exception, List<MarathonByRunner>> either =
        await marathonRepository.fetchMarathonByRunner(event.userEmail);
    MyrunnState marathonState = either.fold(
        (l) => MarathonLoadingFailedByRunner("Oops! there was some error"),
        (r) => MarathonLoadedByRunner(r));
    yield marathonState;
  }

  @override
  Stream<MyrunnState> mapEventToState(
    MyrunnEvent event,
  ) async* {
    if (event is LoadMarathonsByRunner) {
      yield* mapMarathonLoadingByRunnerToState(event);
    }
  }
}
