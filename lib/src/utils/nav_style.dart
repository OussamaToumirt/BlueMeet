import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/src/style/theme.dart';

//style to customize flutter nav
class NavStyle extends StyleHook {
  @override
  double get activeIconSize => 35;

  @override
  double get activeIconMargin => 8;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(
        fontSize: 10, color: CustomTheme.bottomNavTextColor, fontFamily: 'Avenir');
  }
}