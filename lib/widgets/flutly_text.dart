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
    if (isRichText()) {
      return AutoSizeText.rich(
        TextSpan(
          children: getTextWidgets(),
        ),
        textAlign: getTextAlign(),
        maxLines: getMaxLine(),
        minFontSize: flutlyFont.minSize,
        maxFontSize: flutlyFont.maxSize,
        textScaleFactor: 1.sp,
        style: flutlyFont.getTextStyle(font),
      );
    } else {
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
  }

  bool isRichText() => font.toLowerCase().contains("rich-text");

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

  List<TextSpan> getTextWidgets() {
    List<String> texts = text.split("|");

    List<TextSpan> list = List.empty(growable: true);

    for (var i = 0; i < texts.length; i++) {
      String editText = texts[i];
      String newText = editText.substring(1, editText.length);

      list.add(
        TextSpan(
          text: newText,
          style: flutlyFont.getTextStyle(font),
        ),
      );
    }

    return list;
  }

  Color getColorOfRichText(int key) {
    if (key == 0) return const Color.fromRGBO(227, 209, 238, 1.0);
    if (key == 1) return const Color.fromRGBO(193, 180, 201, 1.0);
    if (key == 2) return Colors.transparent;
    if (key == 4) return const Color.fromRGBO(17, 74, 159, 1.0);
    if (key == 8) return Colors.black;
    return Colors.white;
  }
}
