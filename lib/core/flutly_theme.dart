import 'package:flutly/core/flutly_variable.dart';
import 'package:flutly/enums/theme_type.dart';
import 'package:flutly/utilities/flutly_utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyTheme extends GetxController {
  ThemeType selectedTheme = ThemeType.dark;
  late Rx<ThemeData> themeData;

  Map<String, Color> _lightColors = {};
  Map<String, Color> _darkColors = {};

  FlutlyTheme() {
    fetch();
    setup();
  }

  void fetch() {
    FlutlyVariable colorConfig = Get.find(tag: "colors");
    colorConfig.getChildren().keys.forEach(
          (element) => fetchColors(colorConfig, element),
        );

    FlutlyVariable customColorConfig = Get.find(tag: "custom_colors");
    customColorConfig.getChildren().forEach(
      (key, value) {
        fetchCustomColors(value, key);
      },
    );
  }

  void fetchColors(FlutlyVariable colorConfig, String theme) {
    Map<String, FlutlyVariable> colorVariants =
        colorConfig.getChild(theme).getChildren();

    colorVariants.forEach(
      (key, value) {
        String variantKey = key.replaceAll("primary", "");

        fetchCustomColors(
          value,
          theme,
          prefix: variantKey.isEmpty ? "" : "${variantKey}_",
        );
      },
    );
  }

  void fetchCustomColors(FlutlyVariable colorConfig, String theme,
      {String? prefix}) {
    colorConfig.getChildren().forEach(
      (key, value) {
        String subVariantKey =
            FlutlyUtilities.snakeToCamel((prefix ?? "") + key);

        List<String> parts = value.getValue().toString().split(',');

        int r = int.parse(parts[0].trim());
        int g = int.parse(parts[1].trim());
        int b = int.parse(parts[2].trim());
        double a = double.parse((parts.length == 3 ? "1.0" : parts[3]).trim());

        if (theme.contains("dark")) {
          _darkColors.putIfAbsent(
              subVariantKey, () => Color.fromRGBO(r, g, b, a));
        } else {
          _lightColors.putIfAbsent(
              subVariantKey, () => Color.fromRGBO(r, g, b, a));
        }
      },
    );
  }

  void changeTheme(ThemeType type) {
    selectedTheme = type;
    setup();
    update();
  }

  void setup() {
    if (selectedTheme == ThemeType.light) {
      themeData = Rx(
        ThemeData.light().copyWith(
          scaffoldBackgroundColor: getColor("backgroundColor"),
          hintColor: getColor("hintColor"),
          focusColor: getColor("focusColor"),
          disabledColor: getColor("disabledColor"),
          buttonTheme: ButtonThemeData(
            buttonColor: getColor("buttonColor"),
            disabledColor: getColor("buttonDisableColor"),
            hoverColor: getColor("buttonHoverColor"),
            focusColor: getColor("buttonFocusColor"),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: getColor("appBarBackgroundColor"),
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: getColor("drawerBackgroundColor"),
            shadowColor: getColor("drawerShadowColor"),
          ),
          dialogTheme: DialogTheme(
            backgroundColor: getColor("dialogBackgroundColor"),
            iconColor: getColor("dialogIconColor"),
            barrierColor: getColor("dialogBarrierColor"),
            shadowColor: getColor("dialogShadowColor"),
          ),
        ),
      );
    } else {
      themeData = Rx(
        ThemeData.dark().copyWith(
          scaffoldBackgroundColor: getColor("backgroundColor"),
          hintColor: getColor("hintColor"),
          focusColor: getColor("focusColor"),
          disabledColor: getColor("disabledColor"),
          buttonTheme: ButtonThemeData(
            buttonColor: getColor("buttonColor"),
            disabledColor: getColor("buttonDisableColor"),
            hoverColor: getColor("buttonHoverColor"),
            focusColor: getColor("buttonFocusColor"),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: getColor("appBarBackgroundColor"),
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: getColor("drawerBackgroundColor"),
            shadowColor: getColor("drawerShadowColor"),
          ),
          dialogTheme: DialogTheme(
            backgroundColor: getColor("dialogBackgroundColor"),
            iconColor: getColor("dialogIconColor"),
            barrierColor: getColor("dialogBarrierColor"),
            shadowColor: getColor("dialogShadowColor"),
          ),
        ),
      );
    }
  }

  ThemeData getThemeData() => themeData.value;

  Map<String, Color> getColors() =>
      isDark() ? getDarkColors() : getLightColors();

  Map<String, Color> getLightColors() => _lightColors;

  Map<String, Color> getDarkColors() => _darkColors;

  Color? getColor(String key) => getColors()[key];

  Color getDefaultColor() => Colors.black;

  bool isDark() => selectedTheme == ThemeType.dark;
}
