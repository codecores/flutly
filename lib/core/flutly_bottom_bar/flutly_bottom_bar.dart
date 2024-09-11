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
    if (path == "/") {
      return items.firstWhereOrNull(
        (item) => item.page.path == '/',
      );
    }

    List<String> pathSegments =
        path.split('/').where((segment) => segment.isNotEmpty).toList();

    if (pathSegments.isEmpty) return null;

    FlutlyBottomBarItem? parentItem = items.firstWhereOrNull(
      (item) => item.page.path == '/${pathSegments[0]}',
    );

    if (parentItem == null) return null;

    if (pathSegments.length == 1) {
      return parentItem;
    }

    for (int i = 1; i < pathSegments.length; i++) {
      parentItem = parentItem?.children?.firstWhereOrNull(
        (child) => child.page.path == pathSegments[i],
      );

      if (parentItem == null) {
        return null;
      }
    }

    return parentItem;
  }
}
