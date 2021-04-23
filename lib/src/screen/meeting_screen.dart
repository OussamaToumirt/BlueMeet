import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/src/models/get_config_model.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/services/get_config_service.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/widgets/admob_widget.dart';
import 'package:spagreen/src/widgets/host_meeting_card.dart';
import 'package:spagreen/src/widgets/join_meeting_card.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  int _selectedIndex = 0;
  int selectedScreen = 0;
  PageController _pageController;
  GetConfigService configService;
  AuthUser _authUser;
  String appMode;
  String userRole ;
  bool ismandatoryLogin;
  AdmobInterstitial interstitialAd;
  AdsConfig adsConfig;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

    Widget build(BuildContext context) {
    // TODO: implement build
      final authService = Provider.of<AuthService>(context);
       configService = Provider.of<GetConfigService>(context);
      appMode = configService.appConfig() != null? configService.appConfig().appMode:"free";
      _authUser = authService.getUser() != null ? authService.getUser(): null;

      return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
       child: Column(
         children: <Widget>[
           _authUser!=null? appMode == "academic" && _authUser.role == "subscriber"? academicMoodSubscriberWidget():generalMoodWidget():generalMoodWidget(),
         ],
       ),
      ),
        bottomSheet:AdmobWidget(),
    );
  }
  Widget academicMoodSubscriberWidget(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 28),
            child: Text(AppContent.titleMeetingScreen,
              style: CustomTheme.screenTitle,
            ),
          ),
          /*Join meeting and Host Meeting Switch Button*/
          SizedBox(height: 10.0),
          Container(
            height: 500.0,
            child: JoinMeeting(),
          ),
        ],
      ),
    );
  }
  /*Academic Mode Widget*/
  Widget generalMoodWidget(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 28),
            child: Text(AppContent.titleMeetingScreen,
              style: CustomTheme.screenTitle,
            ),
          ),
          /*Join meeting and Host Meeting Switch Button*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              tabButton(0, AppContent.joinMeeting),
              tabButton(1, AppContent.hostMeeting),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            height:430.0,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                /* Join Meeting and Host Meeting Widget*/
                JoinMeeting(),
                HostMeetingCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /*navigate between join meeting and host meeting*/
  Widget tabButton(int btnIndex, String btnTitle) {
    return GestureDetector(
      onTap: () {
        _selectedIndex = btnIndex;
        _pageController.animateToPage(_selectedIndex,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
        setState(() {});
      },
      child: Container(
        height: 40,
        width: MediaQuery
            .of(context)
            .size
            .width / 2.3,
        decoration: BoxDecoration(
          borderRadius: btnIndex == 0
              ? BorderRadius.only(
              topLeft: Radius.circular(6), bottomLeft: Radius.circular(5))
              : BorderRadius.only(
              bottomRight: Radius.circular(6), topRight: Radius.circular(5)),
          boxShadow: _selectedIndex == btnIndex
              ? CustomTheme.iconBoxShadow
              : null,
          color:
          _selectedIndex == btnIndex ? Colors.white : Color(0xffF0F1F6),
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: _selectedIndex == btnIndex ? Color(0xff222222) : Color(
                    0xff5B5D80)),
          ),
        ),
      ),
    );
  }

}
