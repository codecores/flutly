import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/enums/dialog_type.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyDialogApperiances {
  DialogType dialogType;
  
  Color? backgroundColor;

  FlutlyText title;
  FlutlyText description;

  FlutlyDialogActionApperiances? left;
  FlutlyDialogActionApperiances? right;

  FlutlyDialogApperiances({
    required this.dialogType,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.left,
    this.right,
  }){
    backgroundColor ??= Get.find<FlutlyTheme>().getColor("dialogBackgroundColor");
  }
}

class FlutlyDialogActionApperiances {
  Color? buttonColor;
  FlutlyText buttonTitle;
  Function buttonTap;

  FlutlyDialogActionApperiances({required this.buttonTitle, required this.buttonTap, this.buttonColor});
}
