import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/server/repository.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final Repository repository;
  RegistrationBloc(this.repository);
  @override
  RegistrationState get initialState => RegistrationIsNotStartState();
  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationFailed) {
      yield RegistrationFailedState();
    } else if (event is RegistrationCompleting) {
      final user = event.user;
      //print(user);
      AuthUser userServerData = await repository.getRegistrationAuthUser(
        user.name,
        user.email,
        event.password,
      );
      yield RegistrationStateCompleted(userServerData);
    } else if (event is RegistrationNotStarted) {
      yield RegistrationIsNotStartState();
    }else if (event is RegistrationStarted) {
      yield RegistrationStartedState();
    }
  }
}
