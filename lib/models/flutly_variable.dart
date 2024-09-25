import 'package:get/get.dart';

class FlutlyVariable extends GetxController{
  String key;
  Rx<dynamic> value = "".obs;
  Map<String, FlutlyVariable> _children = {};

  FlutlyVariable(this.key, dynamic value, {Map<String, FlutlyVariable>? children}) {
    _children = children ?? {}; 

    this.value = Rx<dynamic>(value);

    if(key != ""){
      Get.lazyPut(()=> this, tag: key);
    }
  }

  dynamic getValue() => value.value;

  Map<String, FlutlyVariable> getChildren() => _children;

  bool childExists(String key) => getChildren().containsKey(key);

  FlutlyVariable getChild(String key) => getChildren()[key] ?? FlutlyVariable("", "null");

  void addChild(String key, FlutlyVariable variable) => getChildren().putIfAbsent(key, () => variable);

  void changeValue(dynamic newValue) {
    value = Rx<dynamic>(newValue);
    update();
  }
}