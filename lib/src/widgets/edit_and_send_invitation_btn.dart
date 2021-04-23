import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';

Widget sendInvitation({String title,String meetingCode,String appName,String joinWebUrl}){
  return  GestureDetector(
    onTap: (){
       String shareText = "${AppContent.joinMeetingWith}"+appName + "\n"+ "${AppContent.joinFromWeb}" +joinWebUrl+ "\n"+"${AppContent.joinFromApp} $meetingCode";
       Share.share(shareText);
    },
    child: Container(
      height: 45.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        border: Border.all(color: CustomTheme.primaryColor),
      ),
      child: Center(child: Text(title,style:CustomTheme.subTitleTextColored,)),
    ),
  );
}
