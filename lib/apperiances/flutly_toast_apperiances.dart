import 'dart:ui';

import 'package:flutly/core/flutly_theme.dart';
import 'package:get/get.dart';

class FlutlyToastApperiances {
  Color? backgroundColor;
  String? textFC;
  double? borderRadius;

  FlutlyToastApperiances({
    this.backgroundColor,
    this.textFC,
    this.borderRadius,
  }) {
    backgroundColor ??= Get.find<FlutlyTheme>().getColor("buttonColor");
    borderRadius ??= 6;

    if(textFC == "" || textFC == null) textFC = "small textColor normal";
  }
}