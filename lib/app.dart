import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'config.dart';
import 'src/models/get_config_model.dart';
import 'src/screen/main_screen.dart';
import 'src/screen/onboard_screen.dart';
import 'src/services/get_config_service.dart';
import 'src/widgets/interner_issue_dialog.dart';
import 'src/widgets/internet_connectivity.dart';
import 'constants.dart';
import 'src/bloc/auth/registration_bloc.dart';
import 'src/bloc/firebase_auth/firebase_auth_bloc.dart';
import 'src/bloc/phone_auth/phone_auth_bloc.dart';
import 'src/screen/login_screen.dart';
import 'src/server/repository.dart';
import 'src/services/authentication_service.dart';
import 'src/utils/route.dart';
import 'src/widgets/animated_splash.dart';
import 'src/bloc/auth/login_bloc.dart';
import 'src/server/phone_auth_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin{
  GetConfigModel getConfigModel;
  bool isFirstSeen = false;
  String notifyContent;

  @override
  void initState() {
    printLog("_MyAppState initState");
    Future.delayed(
      Duration(seconds: 1),
          () {
        MyConnectivity.instance.initialise();
        MyConnectivity.instance.myStream.listen((onData) {
          printLog("[_MyAppState] internet issue change: $onData");

          if (MyConnectivity.instance.isIssue(onData)) {
            if (MyConnectivity.instance.isShow == false) {
              MyConnectivity.instance.isShow = true;
              showDialogNotInternet(context).then((onValue) {
                MyConnectivity.instance.isShow = false;
                printLog("[showDialogNotInternet] dialog closed $onValue");
              });
            }
          } else {
            if (MyConnectivity.instance.isShow == true) {
              Navigator.of(context).pop();
              MyConnectivity.instance.isShow = false;
            }
          }
        });
      },
    );
    super.initState();
    configOneSignal();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async{
    printLog("[_MyAppState] afterFirstLayout");
    isFirstSeen = await checkFirstSeen();
    setState(() {});
  }

  Future checkFirstSeen() async{
    var box =  Hive.box('seenBox');
    bool _seen = await box.get("isFirstSeen") ?? false;
    if(_seen){
      return false;
    }else{
      await box.put("isFirstSeen", true);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    printLog("MyAppState");
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (context) => AuthService(),),
        Provider<GetConfigService>(create: (context) => GetConfigService(),),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc(Repository())),
          BlocProvider(create: (context) => RegistrationBloc(Repository())),
          BlocProvider(create: (context) => FirebaseAuthBloc(Repository())),
          BlocProvider(create: (context) => PhoneAuthBloc(userRepository: UserRepository())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: Routes.getRoute(),
          home: RenderFirstScreen(isFirstSeen: isFirstSeen,),
        ),
      ),
    );
  }
  void configOneSignal() async {
    await OneSignal.shared.init(Config.oneSignalAppID);
    //show notification content
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared.setNotificationReceivedHandler((notification) {
      //content notification
      setState(() {
        notifyContent = notification.jsonRepresentation().replaceAll('\\n', '\n');
      });

    });
  }
}

class RenderFirstScreen extends StatelessWidget {
  bool isMandatoryLogin =false;
  final bool isFirstSeen ;

  RenderFirstScreen({Key key, this.isFirstSeen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    printLog("RenderFirstScreen");
    return ValueListenableBuilder(
      valueListenable: Hive.box<GetConfigModel>('getConfigbox').listenable(),
      builder: (context, box, widget) {
        isMandatoryLogin = box.get(0).appConfig.mandatoryLogin;
        return renderFirstScreen(isMandatoryLogin);
      },
    );
  }
  Widget renderFirstScreen(bool isMandatoryLogin){
    print(isMandatoryLogin);
    if (isFirstSeen) {
      return OnBoardScreen(isMandatoryLogin: isMandatoryLogin,);
    }else if(isMandatoryLogin){
      return LoginPage();
    }else{
      return MainScreen();
    }
  }
}

