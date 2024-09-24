import 'package:flutly/core/flutly_tab_bar/flutly_tab_controller.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_tab_view_controller.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutter/material.dart';

class FlutlyAppBar {
  Color? color;
  double? blur;
  bool? animated;

  FlutlyAppBar({this.color, this.blur, this.animated});

  bool isAnimated() => animated ?? false;
}
