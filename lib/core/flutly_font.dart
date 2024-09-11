import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutlyFont {
  String key;
  double size;
  double minSize;
  double maxSize;

  FlutlyFont(this.key, this.size, this.minSize, this.maxSize);

  TextStyle getTextStyle(String value) {
    FlutlyVariable generalConfig = Get.find(tag: "general");
    bool googleFontActive = generalConfig.childExists("google_font");
    if (googleFontActive) {
      return GoogleFonts.getFont(
        generalConfig.getChild("google_font").getValue(),
        textStyle: TextStyle(
          fontSize: size,
          fontWeight: getFontWeight(value),
          color: getColor(value),
          fontStyle: getFontStyle(value),
          overflow: getTextOverflow(value),
        ),
      );
    }

    String fontFamily = generalConfig.getChild("custom_fount").getValue();

    return TextStyle(
      fontSize: size,
      fontWeight: getFontWeight(value),
      color: getColor(value),
      fontStyle: getFontStyle(value),
      overflow: getTextOverflow(value),
      fontFamily: fontFamily,
    );
  }

  TextOverflow? getTextOverflow(String value) {
    return TextOverflow.values.firstWhereOrNull(
        (element) => value.toLowerCase().contains(" ${element.name.toLowerCase()} "));
  }

  FontStyle getFontStyle(String value) {
    return FontStyle.values.firstWhere(
        (element) => value.toLowerCase().contains(" ${element.name.toLowerCase()} "),
        orElse: () => FontStyle.normal);
  }

  Color getColor(String value) {
    FlutlyTheme flutlyTheme = Get.find<FlutlyTheme>();

    return flutlyTheme
        .getColors()
        .entries
        .firstWhere(
          (entry) => value.toLowerCase().contains(" ${entry.key.toLowerCase()} "),
          orElse: () => MapEntry('', flutlyTheme.getDefaultColor()),
        )
        .value;
  }

  FontWeight getFontWeight(String value) {
    return FontWeight.values.firstWhere(
        (element) =>
            value.toLowerCase().contains(" w${element.value} "),
        orElse: () => FontWeight.w400);
  }
}
