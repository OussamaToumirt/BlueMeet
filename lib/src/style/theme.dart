import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
abstract class CustomTheme {
  static const Color primaryColor = const Color(0xFF8F94FB);
  static const Color primaryColorDark = const Color(0xFF4E54C8);
  static const Color screenTitleColor = const Color(0xff0C233C);
  static const Color white = const Color(0xffffffff);
  static const Color grey = const Color(0xff97AAC3);
  static const Color lightColor = const Color(0xffDBDDF4);
  static const Color redColor = const Color(0xffFF0000);
  static const Color redColorDark = const Color(0xffc62121);
  static const Color bottomNavBGColor = const Color(0xffFCFCFF);
  static const Color bottomNavTextColor = const Color(0xff97AAC3);
  static const Color overlayDark =const Color(0x208F94FB);
  static const String iosMeetingAppBarRGBAColor = "#908F94FB"; //transparent blue

  static const primaryGradient = const LinearGradient(
    colors: const [primaryColor, primaryColorDark],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static TextStyle screenTitle = TextStyle(
    fontFamily: 'NunitoSans',
    color: screenTitleColor,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle btnTitle = TextStyle(
    fontFamily: 'NunitoSans',
    color: white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textFieldTitle = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textFieldTitlePrimaryColored = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColorDark,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle smallTextStyle = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle smallTextStyleRegular = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static TextStyle smallTextStyleColored = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle smallTextStyleColoredUnderLine = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  static TextStyle displayTextOne = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey,
    fontSize: 18,
    fontStyle:FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static TextStyle alartTextStyle = TextStyle(
    fontFamily: 'NunitoSans',
    color: redColor,
    fontSize: 18,
    fontStyle:FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static TextStyle subTitleText = TextStyle(
    fontFamily: 'NunitoSans',
    color: grey,
    fontSize: 14,
    fontStyle:FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static TextStyle subTitleTextColored = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 14,
    fontStyle:FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static TextStyle displayTextColoured = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 18,
    fontStyle:FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static TextStyle displayTextBoldColoured = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle displayTextBoldColouredSmall = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle displayTextBoldPrimaryColor = TextStyle(
    fontFamily: 'NunitoSans',
    color: primaryColorDark,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle displayTextBoldBlackColor = TextStyle(
    fontFamily: 'NunitoSans',
    color: Color(0xff646464),
    fontSize: 16,
  );
  static TextStyle displayErrorText = TextStyle(
    fontFamily: 'NunitoSans',
    color: redColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  //card boxShadow
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      color: overlayDark,
      offset: Offset(0.0, 3.0),
      blurRadius: 7.0,
    ),
  ];
  //icon boxShadow
  static List<BoxShadow> iconBoxShadow = [
    BoxShadow(
      color:overlayDark,
      offset: Offset(1, 6.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: overlayDark,
      offset: Offset(1, 6.0),
      blurRadius: 15.0,
    ),
  ];
  //icon boxShadow
  static List<BoxShadow> navBoxShadow = [BoxShadow(blurRadius: 10,color: Color(0x808F94FB),offset: Offset(1,5))];
  //card Shadow
}
