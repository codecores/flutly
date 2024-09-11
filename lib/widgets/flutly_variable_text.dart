import 'package:flutly/models/flutly_variable.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FlutlyVariableText extends FlutlyText {
  FlutlyVariableText(
    this.tag, {
    required String font,
  }) : super(
          "",
          font: font,
        );

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlutlyVariable>(
      tag: tag,
      builder: (controller) {
        text = controller.getValue();
        return super.build(context);
      },
    );
  }
}
