import 'package:flutly/core/flutly_app_bar/flutly_app_bar.dart';
import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlutlyAbSection extends StatelessWidget {
  FlutlyAppBar? appBar;
  FlutlyBottomBarItem? item;
  double? appBarHeight;

  FlutlyAbSection({
    Key? key,
    required this.appBar,
    required this.item,
    required this.appBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (appBar == null || item == null) {
      return const SizedBox();
    }

    if (appBar!.isAnimated()) {
      return AnimatedContainer(
        width: double.infinity,
        height: appBarHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        alignment: Alignment.center,
        color: appBar!.color ?? Colors.transparent,
        child: SafeArea(child: item!.appBar!),
      );
    }

    return Container(
        width: double.infinity,
        height: appBarHeight,
        alignment: Alignment.center,
        color: appBar!.color ?? Colors.transparent,
        child: SafeArea(child: item!.appBar!),
      );
  }
}
