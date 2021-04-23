import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/src/models/meeting_history_model.dart';
import 'package:spagreen/src/style/theme.dart';

//meeting history row
Widget meetingHistoryRow({MeetingHistoryModel meetingHistoryModel}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 30, top: 20, bottom: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  meetingHistoryModel.nickName,
                  style: CustomTheme.displayTextOne,
                ),
                Text(
                  meetingHistoryModel.meetingCode,
                  style: CustomTheme.displayTextBoldColoured,
                ),
                Text(
                  meetingHistoryModel.joinedAt,
                  style: CustomTheme.subTitleText,
                ),
              ],
            ),
            Image.asset('assets/images/common/refresh.png', width: 25, height: 25,
            ),
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