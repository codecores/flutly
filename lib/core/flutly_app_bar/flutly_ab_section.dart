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

    bool isAnimated = item!.isAnimatedAppBar();

    return AnimatedContainer(
      width: double.infinity,
      height: appBarHeight,
      duration: Duration(milliseconds: isAnimated ? 300 : 0),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.center,
      color: appBar!.color ?? Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: item!.appBar!,
    );
  }
}
