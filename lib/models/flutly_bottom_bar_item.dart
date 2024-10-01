import 'package:flutly/core/flutly_page.dart';
import 'package:flutter/material.dart';

class FlutlyBottomBarItem {
  FlutlyPage page;
  Widget? activePath;
  Widget? deactivePath;

  FlutlyTransactionType? transactionType;
  List<FlutlyBottomBarItem>? children;

  FlutlyBottomBarItem(
      {required this.page,
      this.activePath,
      this.deactivePath,
      this.children,
      this.transactionType,}) {
    deactivePath ??= activePath;
  }

  Widget getActivePath() => activePath ?? const SizedBox();

  Widget getDeactivePath() => deactivePath ?? const SizedBox();

  FlutlyTransactionType getTransactionType() => transactionType ?? FlutlyTransactionType.FADE;

}

enum FlutlyTransactionType { DEFAULT, FADE }
