import 'package:flutter/material.dart';
import 'package:spagreen/src/style/theme.dart';

Widget signupSubmitButton({String iconPath}){
  return Container(
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
      boxShadow: CustomTheme.iconBoxShadow,
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Image.asset(
        'assets/images/authImage/${iconPath}.png',
        width: 45,
        height: 45,
      ),
    ),
  );
}
