import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../button_widget.dart';
import '../strings.dart';
import '../style/theme.dart';
import '../screen/login_screen.dart';

class HistoryWidgetWithoutLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/common/empty_meeting_history.png',
          width: 146,
          height: 146,
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Text(
            AppContent.loginToAccessHistory,
            style: CustomTheme.displayTextOne,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, LoginPage.route);
            },
            child: HelpMe().submitButton(142, AppContent.login)),
        SizedBox(
          height: 45,
        ),
      ],
    );
  }
}