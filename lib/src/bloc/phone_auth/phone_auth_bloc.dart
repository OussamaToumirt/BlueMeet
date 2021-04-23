import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/src/server/phone_auth_repository.dart';
import 'phone_auth_event.dart';
import 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final UserRepository _userRepository;
  StreamSubscription subscription;

  String verID = "";

  PhoneAuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  PhoneAuthState get initialState => InitialLoginState();

  @override
  Stream<PhoneAuthState> mapEventToState(
    PhoneAuthEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      subscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        var result = await _userRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield LoginCompleteState(result.user);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
    }
  }

  @override
  void onEvent(PhoneAuthEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    //print("Bloc closed");
    super.close();
  }

  Stream<PhoneAuthEvent> sendOtp(String phoNo) async* {
    StreamController<PhoneAuthEvent> eventStream = StreamController();
    final PhoneVerificationCompleted = (AuthCredential authCredential) {
      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };
    final PhoneVerificationFailed = (authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final PhoneCodeSent = (String verId, [int forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final PhoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _userRepository.sendOtp(
        phoNo,
        Duration(seconds: 1),
        PhoneVerificationFailed,
        PhoneVerificationCompleted,
        PhoneCodeSent,
        PhoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
