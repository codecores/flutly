library flutly;

import 'package:flutly/core/flulty_fonts.dart';
import 'package:flutly/core/flutly_colors.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutter/material.dart';

import 'package:flutly/widgets/flutly_variable_text.dart';
import 'package:get/get.dart';
import 'package:flutly/widgets/flutly_app.dart';


class Flutly {
  static double screenInitialWidth = 0.0;
  static double screenInitialHeight = 0.0;

  static Future<void> setup() async{
    FlutlyConfig config = FlutlyConfig();
    await config.setup();
    Get.put(config);

    Get.put(FlutlyFonts());
    Get.put(FlutlyColors());
  }

  static void screenConfiguration(BuildContext context) {
    if(screenInitialWidth != 0.0) return;

    screenInitialWidth = MediaQuery.sizeOf(context).width;
    screenInitialHeight = MediaQuery.sizeOf(context).height;
  }
}
