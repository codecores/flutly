import 'package:flutter/material.dart';

class FlutlyAppBarItem {
  String name;
  Widget appBar;
  double? appBarHeight;
  bool? appBarAnimated;

  FlutlyAppBarItem({
    required this.name,
    required this.appBar,
    this.appBarHeight,
    this.appBarAnimated,
  });

  bool isAnimatedAppBar() => appBarAnimated ?? false;
}
