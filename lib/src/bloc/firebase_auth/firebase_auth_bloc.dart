import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spagreen/src/bloc/firebase_auth/firebase_auth_event.dart';
import 'package:spagreen/src/bloc/firebase_auth/firebase_auth_state.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/server/repository.dart';


class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final Repository repository;
  FirebaseAuthBloc(this.repository);
  @override
  FirebaseAuthState get initialState => FirebaseAuthIsNotStartState();
  @override
  Stream<FirebaseAuthState> mapEventToState(FirebaseAuthEvent event) async* {
    if (event is FirebaseAuthFailed) {
      yield FirebaseAuthFailedState();
    } else if (event is FirebaseAuthCompleting) {
      AuthUser userServerData = await repository.getFirebaseAuthUser(
          uid: event.uid,
          email: event.email,
          phone: event.phone,
      );
      yield FirebaseAuthStateCompleted(userServerData);
    } else if (event is FirebaseAuthNotStarted) {
      yield FirebaseAuthIsNotStartState();
    }else if (event is FirebaseAuthStarted) {
      yield FirebaseAuthStartedState();
    }
  }
}
