import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/core/flutly_font.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:get/get.dart';

class FlutlyFonts extends GetxController {
  List<FlutlyFont> fonts = List.empty(growable: true);

  FlutlyFonts() {
    setup();
  }

  void setup() {
    FlutlyVariable fontConfig = Get.find(tag: "fonts");
    Map<String, FlutlyVariable> fontVariants = fontConfig.getChildren();

    fontVariants.forEach(
      (key, value) {
        double size = value.getChild("size").getValue();
        double minSize = value.getChild("min_size").getValue();
        double maxSize = value.getChild("max_size").getValue();

        fonts.add(FlutlyFont(key, size, minSize, maxSize));
      },
    );
  }

  FlutlyFont getFont(String key) {
    return fonts.firstWhere(
        (element) => key.toLowerCase().contains(element.key.toLowerCase()),
        orElse: () => _getDefaultFont());
  }

  FlutlyFont _getDefaultFont() =>
      fonts.firstWhere((element) => element.key == "small");
}
