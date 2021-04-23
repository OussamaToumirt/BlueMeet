import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/src/models/get_config_model.dart';
import 'package:spagreen/src/models/meeting_mode.dart';
import 'package:spagreen/src/server/repository.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/edit_text_utils.dart';
import 'package:spagreen/src/utils/jitsi_meet_utils.dart';
import 'package:spagreen/src/utils/loadingIndicator.dart';
import 'package:spagreen/src/utils/validators.dart';
import '../button_widget.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  final _joinMeetingFormkey = GlobalKey<FormState>();
  Random _rnd = Random();
  TextEditingController meetingIDController = new TextEditingController();
  TextEditingController nickNameController = new TextEditingController();
  MeetingModel joinMeetingResponse;
  bool isLoading = false;
  bool isAdmobClosed = false;
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: JitsiMeetUtils().onConferenceWillJoin,
        onConferenceJoined: JitsiMeetUtils().onConferenceJoined,
        onConferenceTerminated: JitsiMeetUtils().onConferenceTerminated,
        onError: JitsiMeetUtils().onError));

    interstitialAd = AdmobInterstitial(
      adUnitId: Hive.box<GetConfigModel>('getConfigbox').getAt(0).adsConfig.admobInterstitialAdsId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleAdMobEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }

  //AdmobAdEvent will be handled here
  void handleAdMobEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.closed:
      //after cloe interstitialAd ads joinMeetingFunction will be called
        joinMeetingFunction();
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
  void dispose(){
    super.dispose();
    JitsiMeet.removeAllListeners();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final AuthService authService = Provider.of<AuthService>(context);
    double screnWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
      joinMeetingCard(screnWidth,authService),
      if(isLoading)
        spinkit,
    ],);
  }
  /*Join Meeting Widget*/
  Widget joinMeetingCard(double screnWidth,AuthService authService) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 40, bottom: 50, right: 20),
              child: Form(
                key: _joinMeetingFormkey,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppContent.joinAMeeting,
                      style: CustomTheme.displayTextBoldPrimaryColor,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    EditTextUtils().getCustomEditTextField(
                        hintValue: AppContent.meetingID,
                        controller: meetingIDController,
                        prefixWidget: Image.asset('assets/images/common/hash.png', width: 12, height: 16, scale: 3,),
                        keyboardType: TextInputType.text,
                        style: CustomTheme.textFieldTitle,
                        suffixWidget: GestureDetector(
                            onTap: () async {
                              ClipboardData data = await Clipboard.getData('text/plain');
                              meetingIDController.text = data.text;
                              meetingIDController.selection = TextSelection.fromPosition(TextPosition(offset: meetingIDController.text.length));
                            },
                          child: Icon(Icons.content_paste,color: CustomTheme.primaryColor,)),
                          validator: (value){
                          return validateNotEmpty(value);
                        }
                    ),
                    SizedBox(height: 22,),
                    EditTextUtils().getCustomEditTextField(
                      hintValue: AppContent.yourNickName,
                      controller: nickNameController,
                      prefixWidget:Padding(padding: const EdgeInsets.only(left: 9), child: Image.asset('assets/images/common/person.png', width: 16, scale: 3,),),
                      keyboardType: TextInputType.text,
                      style: CustomTheme.textFieldTitle,
                    ),
                    SizedBox(height: 22),
                    GestureDetector(onTap: () async {
                      if(_joinMeetingFormkey.currentState.validate()) {
                        if(await interstitialAd.isLoaded && _rnd.nextInt(100).isEven){
                          //after ads close joninMeetingFunction will be called from handleAdMobEvent
                          interstitialAd.show();
                        }else{
                          // If interstitialAd has not loaded due to any reason simply load hostMeeting Function
                          joinMeetingFunction();
                        }
                      }
                     },
                     child: HelpMe().submitButton(screnWidth, AppContent.joinNow)),
                  ],
                ),
              )
            ),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: CustomTheme.boxShadow,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  joinMeetingFunction() async{
    final AuthService authService = Provider.of<AuthService>(context,listen: false);
    if(_joinMeetingFormkey.currentState.validate()){
      setState(() {isLoading = true;});
      String userId = authService.getUser() != null? authService.getUser().userId : "0";
      //0 is default user id when app is free mode
      joinMeetingResponse =await Repository().joinMeeting(meetingCode: meetingIDController.value.text,userId: userId,nickName: nickNameController.value.text);
      setState(() {isLoading = false;});
      if(joinMeetingResponse != null)
      JitsiMeetUtils().joinMeeting(roomCode: meetingIDController.value.text,nameText: nickNameController.value.text);
    }
  }
}
