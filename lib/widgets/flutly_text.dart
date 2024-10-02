import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutly/core/flutly_fonts.dart';
import 'package:flutly/core/flutly_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FlutlyText extends StatelessWidget {
  FlutlyText(
    this.text, {super.key, 
    required this.font,
  }) {
    FlutlyFonts fonts = Get.find<FlutlyFonts>();
    flutlyFont = fonts.getFont(font);
  }

  String text;
  late String font;
  late FlutlyFont flutlyFont;

  var autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
        text,
        textAlign: getTextAlign(),
        maxLines: getMaxLine(),
        minFontSize: flutlyFont.minSize,
        maxFontSize: flutlyFont.maxSize,
        textScaleFactor: 1.sp,
        style: flutlyFont.getTextStyle(font),
      );
  }

  TextAlign? getTextAlign() {
    return TextAlign.values.firstWhereOrNull(
        (element) => font.toLowerCase().contains(element.name.toLowerCase()));
  }

  int getMaxLine() {
    RegExp exp = RegExp(r"ml-(\d+)");
    Match? match = exp.firstMatch(font);

    if (match != null) {
      return int.tryParse(match.group(1) ?? "") ?? 1;
    }
    return 1;
  }
}
