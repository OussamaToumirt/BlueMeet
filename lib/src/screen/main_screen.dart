import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/services/get_config_service.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/nav_style.dart';
import 'package:spagreen/src/widgets/meeting_bottom_tab_item.dart';
import 'meeting_history.dart';
import 'meeting_history_without_login.dart';
import 'meeting_screen.dart';
import 'setting_screen.dart';


class MainScreen extends StatefulWidget {
  static final String route = '/MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  AuthService authService;
  AuthUser authUser;
  GetConfigService configService;
  bool _keyboardState;
  String appMode = 'free';
  bool ismandatoryLogin;
  TabController _controller;

  @override
  void initState()  {
    _controller = new TabController(vsync: this, length: 3,initialIndex: 1);
    _keyboardState = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      if (this.mounted){
        setState((){
          _keyboardState = visible;
        });
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      configService = Provider.of<GetConfigService>(context);
      ismandatoryLogin = configService.appConfig() != null?configService.appConfig().mandatoryLogin:false;
       authService = Provider.of<AuthService>(context);
       authUser = authService.getUser() != null?authService.getUser():null;

    return Scaffold(
        body: TabBarView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            authUser != null ? MeetingHistoryScreen(userId:authService.getUser().userId,): MeetingHistoryWithoutLogin(),
            MeetingScreen(),
            SettingScreen()
          ],
        ),
        bottomNavigationBar: _keyboardState ? Container(
          height: 0.0, width: 0.0,) :
        Container(
          decoration: BoxDecoration(
            boxShadow: CustomTheme.navBoxShadow,
          ),
          child: Material(
            child: StyleProvider(
              style: NavStyle(),
              child: ConvexAppBar(
                elevation: 0.0,
                height: 60,
                top: -22,
                activeColor: Colors.transparent,
                color: Colors.transparent,
                curveSize: 0.0,
                style: TabStyle.fixedCircle,
                items: [
                  bottomNavigationTabIcon(
                      icon: 'assets/images/tabs/history_inactive.png',
                      activeIcon: 'assets/images/tabs/history_active.png',
                      title: AppContent.tabsHistory),
                  TabItem(
                    isIconBlend: false,
                    activeIcon: Image.asset(
                        'assets/images/tabs/meeting_active.png'),
                    icon: Image.asset('assets/images/tabs/meeting_inactive.png'),
                    title: AppContent.tabsMeetingEmptyText, //no title
                  ),
                  bottomNavigationTabIcon(
                      icon: 'assets/images/tabs/setting_inactive.png',
                      activeIcon: 'assets/images/tabs/setting_active.png',
                      title: AppContent.tabsSettings),
                ],
                backgroundColor: CustomTheme.bottomNavBGColor,
                controller: _controller,
              ),
            ),
          ),
        )
    );
  }
}
