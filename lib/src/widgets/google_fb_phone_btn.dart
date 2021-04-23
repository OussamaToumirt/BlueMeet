import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/src/style/theme.dart';

//this widget is used for google , fb and phone icon
Widget googleFbPhoneButton(String iconPath){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: CustomTheme.iconBoxShadow,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          'assets/images/authImage/${iconPath}.png',
          width: 24,
          height: 24,
        ),
      ),
    ),
  );
}