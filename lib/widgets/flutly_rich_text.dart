import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutly/core/flutly_fonts.dart';
import 'package:flutly/core/flutly_font.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FlutlyRichText extends StatelessWidget {
  FlutlyRichText({
    super.key,
    required this.font,
    required this.texts,
  }) {
    FlutlyFonts fonts = Get.find<FlutlyFonts>();
    flutlyFont = fonts.getFont(font);
  }

  List<FlutlyText> texts = List.empty(growable: true);
  late FlutlyFont flutlyFont;
  late String font;

  var autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        children: texts.map(
          (e) {
            return TextSpan(
              text: e.text + (texts.indexOf(e) == texts.length ? "" : " "),
              style: flutlyFont.getTextStyle(e.font),
            );
          },
        ).toList(),
      ),
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
