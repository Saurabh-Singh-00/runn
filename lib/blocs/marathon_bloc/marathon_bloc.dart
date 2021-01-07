import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'marathon_event.dart';
part 'marathon_state.dart';

class MarathonBloc extends Bloc<MarathonEvent, MarathonState> {
  MarathonBloc() : super(MarathonInitial());

  @override
  Stream<MarathonState> mapEventToState(
    MarathonEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
