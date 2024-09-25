import 'package:flutly/core/flutly_tab_bar/flutly_tab_view_controller.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yaml/yaml.dart';

class FlutlyConfig extends GetxController {
  BuildContext? context;
  RxString currentRoute = "".obs;
  RxDouble currentAppBarHeight = 0.0.obs;
  Map<String, FlutlyVariable> variables = {};

  double screenInitialWidth = 0.0;
  double screenInitialHeight = 0.0;

  bool bottomBarHidden = false;
  bool keyboardShowing = false;

  List<FlutlyTabViewController> tabBars = List.empty(growable: true);

  Future<void> setup(YamlMap config) async {
    config.forEach(
      (key, value) {
        FlutlyVariable variable = FlutlyVariable(key, value);
        variables.putIfAbsent(key, () => variable);
        if (value.runtimeType == YamlMap) {
          readYamlMap(variable, value);
        }
      },
    );

    return;
  }

  void readYamlMap(FlutlyVariable variable, YamlMap map) {
    map.forEach(
      (key, value) {
        FlutlyVariable newVariable = FlutlyVariable(key, value);
        variable.addChild(key, newVariable);
        if (value.runtimeType == YamlMap) readYamlMap(newVariable, value);
      },
    );
  }

  FlutlyVariable getVariable(String key) {
    return variables[key] ?? FlutlyVariable("", "null");
  }

  String getCurrentRoute() => currentRoute.value;
  double getCurrentAppBarHeight() => currentAppBarHeight.value;

  void setCurrentRoute(String route, double appBarHeight) async{
    await Future.delayed(const Duration(milliseconds: 10));
    currentRoute = RxString(route);
    currentAppBarHeight = RxDouble(appBarHeight);
    update();
  }

  void setBottomBarHidden(bool value){
    bottomBarHidden = value;
    update();
  }

  void setKeyboardShowing(bool value){
    if(keyboardShowing == value) return;
    keyboardShowing = value;
    update();
  }
}
