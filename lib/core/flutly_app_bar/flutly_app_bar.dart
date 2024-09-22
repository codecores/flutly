import 'package:flutly/core/flutly_app_bar/flutly_tab_controller.dart';
import 'package:flutly/core/flutly_app_bar/flutly_tab_view_controller.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutter/material.dart';

class FlutlyAppBar {
  Color? color;
  double? blur;
  bool? animated;
  FlutlyTabViewController? tabViewController;

  FlutlyAppBar({this.color, this.blur, this.animated, this.tabViewController});

  bool isAnimated() => animated ?? false;

  Widget getWidget(Widget child) {
    if (tabViewController != null) {
      return FlutlyTabController(
        viewController: tabViewController!,
        child: child,
      );
    }

    return child;
  }
}
