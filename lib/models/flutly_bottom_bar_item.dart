import 'package:flutly/core/flutly_page.dart';
import 'package:flutter/material.dart';

class FlutlyBottomBarItem {
  FlutlyPage page;
  Widget activePath;
  Widget? deactivePath;
  Widget? appBar;
  double? appBarHeight;
  FlutlyTransactionType? transactionType = FlutlyTransactionType.DEFAULT;
  List<FlutlyBottomBarItem>? children;

  FlutlyBottomBarItem({required this.page, required this.activePath, this.appBar, this.appBarHeight, this.deactivePath, this.children, this.transactionType}){
    deactivePath ??= activePath;
  }
}

enum FlutlyTransactionType {DEFAULT, FADE}