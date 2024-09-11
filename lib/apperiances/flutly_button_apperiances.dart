import 'package:flutly/core/flutly_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyButtonApperiances {
  double? width;
  double? height;
  bool? expanded;
  Color? backgroundColor;
  String? textFC;
  double? borderRadius;

  FlutlyButtonApperiances({
    this.width,
    this.height,
    this.expanded,
    this.backgroundColor,
    this.textFC,
    this.borderRadius,
  }) {
    backgroundColor ??= Get.find<FlutlyTheme>().getColor("buttonColor");
    borderRadius ??= 0;
    expanded ??= false;
    width ??= 100;
    height ??= 40;

    if(textFC == "" || textFC == null) textFC = "small textColor normal";
  }
}
