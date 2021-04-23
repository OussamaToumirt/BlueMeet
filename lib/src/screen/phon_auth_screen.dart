import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/src/bloc/firebase_auth/firebase_auth_bloc.dart';
import 'package:spagreen/src/bloc/firebase_auth/firebase_auth_event.dart';
import 'package:spagreen/src/bloc/firebase_auth/firebase_auth_state.dart';
import 'package:spagreen/src/bloc/phone_auth/phone_auth_bloc.dart';
import 'package:spagreen/src/bloc/phone_auth/phone_auth_state.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/server/phone_auth_repository.dart';
import 'package:spagreen/src/screen/main_screen.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/loadingIndicator.dart';
import 'package:spagreen/src/widgets/otp_input.dart';
import 'package:spagreen/src/widgets/phone_number_input.dart';
import '../strings.dart';

Bloc firebaseAuthBloc;

class PhoneAuthScreen extends StatelessWidget {
  static final String route = '/PhoneAuthScreen';
  final UserRepository userRepository;

  PhoneAuthScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
      listener: (context, state) {
        if (state is FirebaseAuthStateCompleted) {
          AuthUser user = state.getUser;
          if (user == null) {
            firebaseAuthBloc.add(FirebaseAuthFailed);
          } else {
            //print('registration succeed');
            authService.updateUser(user);
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false);
        }
      },
      child: BlocProvider<PhoneAuthBloc>(
        create: (context) => PhoneAuthBloc(userRepository: userRepository),
        child: Scaffold(
          body: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  PhoneAuthBloc _phonAuthBloc;

  @override
  void initState() {
    _phonAuthBloc = BlocProvider.of<PhoneAuthBloc>(context);
    firebaseAuthBloc = BlocProvider.of<FirebaseAuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      bloc: _phonAuthBloc,
      listener: (context, loginState) {
        if (loginState is ExceptionState || loginState is OtpExceptionState) {
          String message;
          if (loginState is ExceptionState) {
            message = loginState.message;
          } else if (loginState is OtpExceptionState) {
            message = loginState.message;
          }
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppContent.phoneAuthTitle),
              backgroundColor: CustomTheme.primaryColor,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Container(
                      child: getViewAsPerState(state),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  //renderViewsPerState
  getViewAsPerState(PhoneAuthState state) {
    if (state is OtpSentState || state is OtpExceptionState) {
      return OtpInput();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else if (state is LoginCompleteState) {
      FirebaseUser fbUser = state.getUser();
      if (fbUser != null) {
        firebaseAuthBloc.add(FirebaseAuthStarted());
        firebaseAuthBloc.add(FirebaseAuthCompleting(
          uid: fbUser.uid,
          phone: fbUser.phoneNumber,
        ));
      }
      return LoadingIndicator();
    } else {
      return NumberInput();
    }
  }
}
