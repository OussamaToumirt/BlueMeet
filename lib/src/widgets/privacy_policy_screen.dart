import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:spagreen/src/models/privacy_policy_model.dart';
import 'package:spagreen/src/server/repository.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/loadingIndicator.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  static final String route = '/PrivacyPolicyScreen';

  PrivacyPolicyScreen({
    Key key,
  }) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PrivacyPolicyModel privacyPolicyModel;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPrivacyPolicy();
  }

  fetchPrivacyPolicy() async {
    privacyPolicyModel = await Repository().privacyPolicyResponse();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CustomTheme.primaryColor,
        title: Text(AppContent.privacyPolicy),),
      body: privacyPolicyModel != null ?SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Html(
            data: """ ${privacyPolicyModel.privacyPolicyText}""",
          ),
        ),
      ):Container(child: Center(
        child: spinkit,
      ),),
    );
  }
}
