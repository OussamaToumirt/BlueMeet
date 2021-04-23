import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
//customized flutter bottom Navigation
TabItem<dynamic> bottomNavigationTabIcon(
    {String icon, activeIcon, String title}) {
  return TabItem(
    isIconBlend: false,
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Image.asset(icon),
    ),
    activeIcon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Image.asset(activeIcon),
    ),
    title: title,
  );
}