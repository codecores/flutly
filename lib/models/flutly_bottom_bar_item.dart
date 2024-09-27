import 'package:flutly/core/flutly_page.dart';
import 'package:flutter/material.dart';

class FlutlyBottomBarItem {
  FlutlyPage page;
  Widget activePath;
  Widget? deactivePath;
  Widget? appBar;
  double? appBarHeight;
  bool? appBarAnimated;

  FlutlyTransactionType? transactionType = FlutlyTransactionType.DEFAULT;
  List<FlutlyBottomBarItem>? children;

  FlutlyBottomBarItem(
      {required this.page,
      required this.activePath,
      this.appBar,
      this.appBarHeight,
      this.appBarAnimated,
      this.deactivePath,
      this.children,
      this.transactionType,}) {
    deactivePath ??= activePath;
  }

  bool isAnimatedAppBar() => appBarAnimated ?? false;
  FlutlyTransactionType getTransactionType() => transactionType ?? FlutlyTransactionType.DEFAULT;

}

enum FlutlyTransactionType { DEFAULT, FADE }
