import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutly/core/flutly_config_builder.dart';
import 'package:flutly/core/flutly_fonts.dart';
import 'package:flutly/core/flutly_font.dart';
import 'package:flutly/widgets/flutly_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FlutlyText extends FlutlyStatelessWidget {
  FlutlyText(
    this.text, {
    super.key,
    required this.font,
    this.shimmer,
  }) {
    FlutlyFonts fonts = Get.find<FlutlyFonts>();
    flutlyFont = fonts.getFont(font);
    setShimmerType(FlutlyShimmerType.TEXT);
    shimmer ??= false;

    setCanShimmer(shimmer!);
  }

  String text;
  late String font;
  late FlutlyFont flutlyFont;
  bool? shimmer;

  var autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return FlutlyConfigBuilder(
      builder: (controller) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AutoSizeText(
              text,
              textAlign: getTextAlign(),
              maxLines: getMaxLine(),
              minFontSize: flutlyFont.minSize,
              maxFontSize: flutlyFont.maxSize,
              textScaleFactor: 1.sp,
              style: flutlyFont.getTextStyle(font),
            ).animate(target: canShimmer! ? (controller.onShimmer.value ? 0 : 1) : 1).fadeIn(),
            super.build(context),
          ],
        );
      },
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
