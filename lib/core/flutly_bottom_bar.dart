import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyBottomBar {
  double? height;
  double? itemSize;
  Color? color;
  bool? blured;
  List<FlutlyBottomBarItem> items;

  FlutlyBottomBar(
      {required this.items,
      this.blured,
      this.height,
      this.itemSize,
      this.color});

  FlutlyBottomBarItem? getItemWithPath(String path) {
    return items.firstWhereOrNull(
      (item) => item.page.path == path,
    );
  }
}
