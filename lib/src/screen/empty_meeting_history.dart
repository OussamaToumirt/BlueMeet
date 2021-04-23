import 'package:flutter/material.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import '../../constants.dart';
import '../button_widget.dart';
import 'main_screen.dart';

class EmptyMeetingHistory extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
    printLog("EmptyMeetingHistory");
    double screnWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 70.0),
          Image.asset('assets/images/common/empty_meeting_history.png', width: 146.0, height: 146.0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: AppContent.noMeetingHistory,
              style: CustomTheme.displayTextOne,
              children: <TextSpan>[
                TextSpan(text: AppContent.joinMeetingSuggest, style: CustomTheme.displayTextColoured),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          GestureDetector(
              onTap: (){
                Navigator.of(context).popAndPushNamed(MainScreen.route);
              },
              child: HelpMe().submitButton(screnWidth, AppContent.joinMeeting))
        ],
      ),
    );
  }
}
