import 'package:flutly/core/flutly_variable.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yaml/yaml.dart';

class FlutlyConfig extends GetxController {
  Map<String, FlutlyVariable> variables = {};

  double screenInitialWidth = 0.0;
  double screenInitialHeight = 0.0;

  Future<void> setup() async {
    final yamlString = await rootBundle.loadString('assets/config.yaml');
    YamlMap yamlData = loadYaml(yamlString);

    yamlData.forEach(
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
}
