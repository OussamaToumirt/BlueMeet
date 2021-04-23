import 'package:app_review/app_review.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/app.dart';
import 'package:spagreen/config.dart';
import 'package:spagreen/constants.dart';
import 'package:spagreen/src/button_widget.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/services/get_config_service.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/validators.dart';
import 'package:spagreen/src/widgets/edit_and_send_invitation_btn.dart';
import 'package:spagreen/src/widgets/user_info_card.dart';
import 'package:spagreen/src/widgets/privacy_policy_screen.dart';
import '../widgets/setting_widget_without_login.dart';
import 'package:package_info/package_info.dart';
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  GetConfigService configService;
  AuthService authService;
  bool ismandatoryLogin;
  AuthUser authUser;
  String output = "";
  PackageInfo _packageInfo = PackageInfo(
    appName: 'AppName',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  String joinWebUrl;
  final _auth = FirebaseAuth.instance;

  ///authUserUpdated will be called from edit profile screen if user update user info.
  void authUserUpdated(){
    if (this.mounted){
      setState((){});
    }
   }

  @override
  initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  @override
  Widget build(BuildContext context) {
    printLog('SeetingScreen');
    authService = Provider.of<AuthService>(context);
    authUser = authService.getUser() != null ? authService.getUser() : null;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _renderAppBar(),
                if(authUser != null )
                  userInfoCard(authUser, context,authUserUpdated),
                if(authUser != null)
                  logoutSection(),
                if(authUser != null )
                  _renderPersonalMeetingCard( authUser),
                if(authUser == null)
                  SeetingWidgetWithoutLogin(),
                appThemeVersionPrivacy(context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    AppContent.copyrightText,
                    textAlign: TextAlign.center,
                    style: CustomTheme.smallTextStyleRegular,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 28.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppContent.titleSettingsScreen,
                style: CustomTheme.screenTitle,
              ),
              Text(
                AppContent.subTitleSettingsScreen,
                style: CustomTheme.displayTextOne,
              )
            ],
          )),
    );
  }

  Widget _renderPersonalMeetingCard(AuthUser authUser) {
    joinWebUrl =  "${Config.baseUrl}room/${authUser.meetingCode}";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 25.0, bottom: 25.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppContent.myPersonalMeetingID, style: CustomTheme.displayTextBoldPrimaryColor),
              SizedBox(height: 30.0),

              Container(
                height: 44.0,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  border: Border.all(color: CustomTheme.lightColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Image.asset('assets/images/common/hash.png', width: 12, height: 16, scale: 3),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(authUser.meetingCode, style: CustomTheme.textFieldTitlePrimaryColored,),
                        ),
                      ],),
                      GestureDetector(
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: authUser.meetingCode)).then((_){
                              showShortToast(AppContent.meetingIDcopied);
                            });
                          },
                          child: Icon(Icons.content_copy,color: CustomTheme.primaryColor,)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 14),
              sendInvitation(title: AppContent.sendInvitation, meetingCode: authUser.meetingCode,appName: _packageInfo.appName,joinWebUrl: joinWebUrl,),
            ],
          ),
        ),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: CustomTheme.boxShadow,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget appThemeVersionPrivacy(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {
              AppReview.storeListing.then((onValue) {
                setState(() {
                  output = onValue;
                });
                print(onValue);
              });
            },
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0.0, horizontal: 20.0),
            title: Text(AppContent.rateAndReview, style: CustomTheme.displayTextOne,
            ),
            trailing: Image.asset('assets/images/common/arrow_forward.png', scale: 2.5,),
          ),
          Divider(
            color: CustomTheme.grey,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0.0, horizontal: 20.0),
            title: Text(
              AppContent.version,
              style: CustomTheme.displayTextOne,
            ),
            trailing: Text(
              "${_packageInfo.version}(${_packageInfo.buildNumber})",
              style: CustomTheme.displayTextOne,
            ),
          ),
          Divider(
            color: CustomTheme.grey,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0.0, horizontal: 20.0),
            onTap: () {
              Navigator.pushNamed(context, PrivacyPolicyScreen.route);
            },
            title: Text(
              AppContent.privacyPolicy,
              style: CustomTheme.displayTextOne,
            ),
            trailing: Image.asset(
              'assets/images/common/arrow_forward.png',
              scale: 2.5,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: CustomTheme.boxShadow,
        color: Colors.white,
      ),
    );
  }

  Widget logoutSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: (){
          showDialog(context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  content:  Text(AppContent.areYouSureLogout),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                  actionsPadding: EdgeInsets.only(right: 15.0),
                  actions: <Widget>[
                    GestureDetector(
                        onTap: ()async{
                          await _auth.signOut();
                          if(authService.getUser() != null)
                            authService.deleteUser();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              MyApp()), (Route<dynamic> route) => false);},
                        child: HelpMe().accountDeactivate(60, AppContent.yesText,height: 30.0)),
                    SizedBox(width: 8.0,),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: HelpMe().submitButton(60, AppContent.noText,height: 30.0)),
                  ],
                );
              }
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: 20.0),
                title: Text(AppContent.logout, style: CustomTheme.alartTextStyle,),
              ),
            ],
          ),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: CustomTheme.boxShadow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

