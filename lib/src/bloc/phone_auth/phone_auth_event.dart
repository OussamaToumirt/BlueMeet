import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends PhoneAuthEvent {
  String phoNo;
  SendOtpEvent({this.phoNo});
}

class AppStartEvent extends PhoneAuthEvent {}

class VerifyOtpEvent extends PhoneAuthEvent {
  String otp;
  VerifyOtpEvent({this.otp});
}

class LogoutEvent extends PhoneAuthEvent {}

class OtpSendEvent extends PhoneAuthEvent {}

class LoginCompleteEvent extends PhoneAuthEvent {
  final FirebaseUser firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends PhoneAuthEvent {
  String message;
  LoginExceptionEvent(this.message);
}
