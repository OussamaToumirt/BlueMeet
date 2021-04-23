import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/constants.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/widgets/admob_widget.dart';
import 'package:spagreen/src/widgets/history_widget_without_login.dart';


class MeetingHistoryWithoutLogin extends StatefulWidget {
  const MeetingHistoryWithoutLogin({Key key}) : super(key: key);

  @override
  _MeetingHistoryWithoutLoginState createState() => _MeetingHistoryWithoutLoginState();
}

class _MeetingHistoryWithoutLoginState extends State<MeetingHistoryWithoutLogin> {
  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_MeetingHistoryWithoutLoginState");
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(AppContent.titleMeetingHistory, style: CustomTheme.screenTitle,),
                          Text(AppContent.allMeetingHistory, style: CustomTheme.displayTextOne,)
                        ],
                      )),
                  SizedBox(height: 20.0),
                  HistoryWidgetWithoutLogin(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: AdmobWidget(),
    );
  }
}
