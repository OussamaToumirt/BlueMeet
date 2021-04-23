import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthEvent extends Equatable{
  @override
  List<Object> get props => null;
}
class FirebaseAuthCompleting extends FirebaseAuthEvent{
  final uid;
  final email;
  final phone;
  FirebaseAuthCompleting({@required this.uid,this.email,this.phone});
  @override
  List<Object> get props => [uid,email,phone];
}
class FirebaseAuthFailed extends FirebaseAuthEvent{
  @override
  List<Object> get props => super.props;
}
class FirebaseAuthNotStarted extends FirebaseAuthEvent{
  @override
  List<Object> get props => super.props;
}
class FirebaseAuthStarted extends FirebaseAuthEvent{
  @override
  List<Object> get props => super.props;
}