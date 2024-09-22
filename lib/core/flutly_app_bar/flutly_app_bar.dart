import 'package:flutly/core/flutly_app_bar/flutly_tab_view_controller.dart';
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
      return DefaultTabController(
        length: tabViewController!.length,
        animationDuration: tabViewController!.animationDuration,
        initialIndex: tabViewController!.initalIndex!,
        child: child,
      );
    }

    return child;
  }
}
