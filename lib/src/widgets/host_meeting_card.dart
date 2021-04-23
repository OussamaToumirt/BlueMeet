import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../config.dart';
import '../button_widget.dart';
import 'edit_and_send_invitation_btn.dart';
import 'package:package_info/package_info.dart';

class HostMeetingCard extends StatefulWidget {
  @override
  _HostMettingCardState createState() => _HostMettingCardState();
}

class _HostMettingCardState extends State<HostMeetingCard> {
  TextEditingController meetingTitleController = new TextEditingController();
  MeetingModel hostMeetingResponse;
  PackageInfo _packageInfo = PackageInfo(appName: 'AppName');
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'; //all characters
  Random _rnd = Random();
  String randomMeetingCode; //meeting room
  bool isLoading = false;
  String joinWebUrl;
  String meetingPrefix;
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    _initPackageInfo();
     meetingPrefix = Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.meetingPrefix;
    randomMeetingCode = meetingPrefix + getRandomString(9);
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
    super.initState();
  }
  //AdmobAdEvent will be handled here
  void handleAdMobEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.closed:
        //after cloe interstitialAd ads hostMeeting function will be called
        hostMeetingFunction();
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  //Regerating Random Meeting Code
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    joinWebUrl = "${Config.baseUrl}room/$randomMeetingCode";
    double screnWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        joinMeetingCard(screnWidth, authService),
        if (isLoading) spinkit,
      ],
    );
  }

  Widget joinMeetingCard(double screnWidth, AuthService authService) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 40, bottom: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppContent.createAMeeting,
                    style: CustomTheme.displayTextBoldPrimaryColor,
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 48.0,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      border: Border.all(color: CustomTheme.lightColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/images/common/hash.png', scale: 3.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  randomMeetingCode,
                                  style: CustomTheme.textFieldTitle,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(new ClipboardData(
                                        text: randomMeetingCode))
                                    .then((_) {
                                  showShortToast(AppContent.meetingIDcopied);
                                });
                              },
                              child: Icon(Icons.content_copy, color: CustomTheme.primaryColor,)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  /* user meeting title textField */
                  EditTextUtils().getCustomEditTextField(
                    hintValue: AppContent.meetingTitleOptional,
                    controller: meetingTitleController,
                    prefixWidget: Image.asset('assets/images/common/person.png', scale: 3,),
                    keyboardType: TextInputType.text,
                    style: CustomTheme.textFieldTitle,
                  ),
                  SizedBox(height: 15.0),
                  sendInvitation(
                      title: AppContent.sendInvitation,
                      meetingCode: randomMeetingCode,
                      appName: _packageInfo.appName,
                      joinWebUrl: joinWebUrl),
                  SizedBox(height: 15.0),
                  GestureDetector(
                      onTap: () async {
                        if(await interstitialAd.isLoaded && _rnd.nextInt(100).isEven){
                          //after interstitialAd close joninMeetingFunction will be called from handleAdMobEvent
                          interstitialAd.show();
                        }else{
                          // If interstitialAd has not loaded due to any reason simply load hostMeeting Function
                          hostMeetingFunction();
                        }
                      },
                      child: HelpMe().submitButton(screnWidth, AppContent.createJoinNow))
                ],
              ),
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
  hostMeetingFunction()async{
    final AuthService authService = Provider.of<AuthService>(context,listen: false);
    setState(() {isLoading = true;});
    String meetingTitle = meetingTitleController.value.text ?? ' ';
    String userId = authService.getUser() != null ? authService.getUser().userId : "0";
    //0 is default user id when app is free mode
    hostMeetingResponse = await Repository().hostMeeting(meetingCode: randomMeetingCode, userId: userId, meetingTitle: meetingTitle);
    /*print(hostMeetingResponse);*/
    setState(() {isLoading = false;});
    if (hostMeetingResponse != null)
    JitsiMeetUtils().hostMeeting(roomCode: randomMeetingCode, meetingTitle: meetingTitle);
  }
}
