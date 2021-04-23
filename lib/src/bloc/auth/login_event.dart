import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class LoginEvent extends Equatable{
  @override
  List<Object> get props => null;
}
class LoginCompleting extends LoginEvent{
  final String email;
  final String password;

  LoginCompleting({@required this.email,@required this.password});
  @override
  List<Object> get props => [email,password];
}
class LoginCompletingFailed extends LoginEvent{
  @override
  List<Object> get props => super.props;
}
class LoginCompletingNotStarted extends LoginEvent{
  @override
  List<Object> get props => super.props;
}
class LoginCompletingStarted extends LoginEvent{
  @override
  List<Object> get props => super.props;
}
