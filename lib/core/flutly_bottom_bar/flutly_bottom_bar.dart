import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FlutlyBottomBar {
  double? height;
  double? itemSize;
  Color? color;
  double? blur;
  Widget? separator;
  double? leadingHeight;
  Widget? leading;
  List<FlutlyBottomBarItem> items;

  FlutlyBottomBar({
    required this.items,
    this.blur,
    this.height,
    this.itemSize,
    this.color,
    this.separator,
    this.leadingHeight,
    this.leading,
  });

  Color getColor(BuildContext context) => color ?? Theme.of(context).scaffoldBackgroundColor;

  double getBarHeight() => getHeight() + getLeadingHeight();

  double getHeight() => height ?? 80;

  double getLeadingHeight() => leadingHeight ?? 0;

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
