import 'package:flutter/material.dart';
import 'package:spagreen/src/style/theme.dart';
class HelpMe{
  Widget submitButton(double width,String title,{double height = 40}){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [CustomTheme.primaryColor, CustomTheme.primaryColorDark],
              begin:Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Center(
          child: Text(
            title,
            style: CustomTheme.btnTitle,
          )),
    );
  }
  Widget accountDeactivate(double width,String title,{double height = 40}){
    return Container(
      height: height,
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [CustomTheme.redColor, CustomTheme.redColorDark],
              begin:Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      width: width,
      child: Center(
          child: Text(
            title,
            style: CustomTheme.btnTitle,
          )),
    );
  }
}