import 'package:flutly/core/flutly_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyColors extends GetxController {
  Map<String, Color> _colors = {};

  FlutlyColors() {
    setup();
  }

  void setup() {
    FlutlyVariable colorConfig = Get.find(tag: "colors");

    Map<String, FlutlyVariable> colorVariants = colorConfig.getChildren();

    colorVariants.forEach(
      (key, value) {
        List<String> parts = value.getValue().toString().split(',');

        int r = int.parse(parts[0].trim());
        int g = int.parse(parts[1].trim());
        int b = int.parse(parts[2].trim());
        double a = double.parse((parts.length == 3 ? "1.0" : parts[3]).trim());

        _colors.putIfAbsent(key, () => Color.fromRGBO(r, g, b, a));
      },
    );
  }

  Map<String, Color> getColors() => _colors;

  Color getColor(String key) => _colors[key] ?? getDefaultColor();

  Color getDefaultColor() => Colors.black;
}
