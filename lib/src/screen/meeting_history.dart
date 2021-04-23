import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/src/models/meeting_history_model.dart';
import 'package:spagreen/src/models/meeting_mode.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/server/repository.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/jitsi_meet_utils.dart';
import 'package:spagreen/src/utils/loadingIndicator.dart';
import 'package:spagreen/src/widgets/admob_widget.dart';
import 'package:spagreen/src/widgets/meeting_history_row.dart';
import '../strings.dart';
import 'empty_meeting_history.dart';

class MeetingHistoryScreen extends StatelessWidget {
  //18item length per page
  static const int PAGE_SIZE = 18;
  static const int PAGE_NUMBER = 1;
  final userId;
  MeetingModel joinMeetingResponse;
  AuthUser authUser;


  MeetingHistoryScreen({Key key,@required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    authUser = authService.getUser() != null?authService.getUser():null;

    return Scaffold(
        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppContent.titleMeetingHistory,
                            style: CustomTheme.screenTitle,
                          ),
                          Text(
                            AppContent.allMeetingHistory,
                            style: CustomTheme.displayTextOne,
                          )
                        ],
                      )),
                ),
              ),
              PagewiseSliverList(
                pageSize: PAGE_SIZE,
                itemBuilder: this._itemBuilder,
                pageFuture: (pageIndex) {
                  /*page number should start from 1*/
                  String pageNumber = (pageIndex * PAGE_NUMBER + 1) .toString();
                  return Repository.meetingHistoryPagination(userId,pageNumber);
                },
                noItemsFoundBuilder: (context){
                  return  EmptyMeetingHistory();
                },
                  loadingBuilder: (context) {
                    return spinkit;
                  }
              ),
            ],
          ),
        ),
        bottomSheet: AdmobWidget(),
      );
  }

  Widget _itemBuilder(context,MeetingHistoryModel meetingHistoryModel,_){
    return GestureDetector(
        onTap: ()async{
          String userId = authUser != null? authUser.userId : "0"; //defaultUserID 0
          joinMeetingResponse =await Repository().joinMeeting(meetingCode: meetingHistoryModel.meetingCode,userId: userId,nickName: meetingHistoryModel.nickName);
          if(joinMeetingResponse != null)
          JitsiMeetUtils().joinMeeting(roomCode: meetingHistoryModel.meetingCode,nameText: meetingHistoryModel.nickName);
        },
        child: meetingHistoryRow(meetingHistoryModel: meetingHistoryModel));
  }
}
