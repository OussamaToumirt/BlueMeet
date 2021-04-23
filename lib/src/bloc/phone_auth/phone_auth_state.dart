import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneAuthState extends Equatable {}

class InitialLoginState extends PhoneAuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OtpSentState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends PhoneAuthState {
  FirebaseUser _firebaseUser;
  LoginCompleteState(this._firebaseUser);

  FirebaseUser getUser(){
    return _firebaseUser;
  }
  @override
  List<Object> get props => [_firebaseUser];
}

class ExceptionState extends PhoneAuthState {
  String message;
  ExceptionState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class OtpExceptionState extends PhoneAuthState {
  String message;
  OtpExceptionState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
