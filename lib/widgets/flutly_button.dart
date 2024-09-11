import 'package:flutly/apperiances/flutly_button_apperiances.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FlutlyButton extends StatelessWidget {
  FlutlyButton({
    super.key,
    required this.buttonType,
    required this.onTap,
    this.child,
    this.apperiances,
    this.text,
  });

  FlutlyButtonApperiances? apperiances;
  ButtonType? buttonType = ButtonType.BOUNCING;
  Function onTap;
  Widget? child;
  String? text;

  @override
  Widget build(BuildContext context) {
    if (child == null && text == null) {
      throw (
        "Flutly -> 'child' and 'text' cannot be null at the same time. Please define child or apperiances parameters.",
      );
    }

    bool isExpanded = false;

    if (apperiances != null) {
      isExpanded = apperiances!.expanded!;
    }

    if (buttonType == ButtonType.BOUNCING) {
      return isExpanded
          ? Flexible(
              child: Bounceable(
                  onTap: () => onTap(), child: child ?? generateButton()),
            )
          : Bounceable(onTap: () => onTap(), child: child ?? generateButton());
    }

    return GestureDetector(
        onTap: () => onTap(), child: child ?? generateButton());
  }

  Widget generateButton() {
    FlutlyTheme flutlyTheme = Get.find();

    apperiances ??= FlutlyButtonApperiances(
        backgroundColor: flutlyTheme.getColor("buttonColor"),
        borderRadius: 0,
        expanded: false,
        width: 100,
        height: 40,
        textFC: "small textColor normal");

    return Container(
      width: apperiances!.width,
      height: apperiances!.height,
      decoration: BoxDecoration(
        color: apperiances!.backgroundColor,
        borderRadius:
            BorderRadius.all(Radius.circular(apperiances!.borderRadius!)),
      ),
      child: Center(
        child: FlutlyText(text!, font: apperiances!.textFC!),
      ),
    );
  }
}
