import 'package:flutter/material.dart';

class FlutlyAppBar {
  Color? color;
  bool? blured;
  bool? animated;

  FlutlyAppBar({this.color, this.blured, this.animated});

  bool isAnimated() => animated ?? false;
  
}