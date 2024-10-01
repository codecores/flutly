import 'package:flutly/core/flutly_app_bar/flutly_app_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyAppBar {
  Color? color;
  double? blur;

  List<FlutlyAppBarItem>? bars = List.empty(growable: true);

  FlutlyAppBar({this.color, this.blur, this.bars});

  FlutlyAppBarItem? getBar(String name){
    if(bars == null) return null;
    print("TARANAN APP BAR : " + name);
    return bars!.firstWhereOrNull((element) => element.name == name);
  }
}
