import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';

Future<dynamic> showDialogNotInternet(BuildContext context) {
  return showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Center(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.warning,color: CustomTheme.redColor,),
              ),
              Text(AppContent.internetIssue,style: CustomTheme.displayErrorText,),
            ],
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(AppContent.checkInternetConnection,style: CustomTheme.displayTextColoured,),
        ),
      ));
}
