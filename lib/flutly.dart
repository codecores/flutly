library flutly;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flulty_fonts.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/core/flutly_variable.dart';
import 'package:flutter/material.dart';

import 'package:flutly/widgets/flutly_variable_text.dart';
import 'package:get/get.dart';
import 'package:flutly/widgets/flutly_app.dart';
import 'package:yaml/yaml.dart';

class Flutly {
  static double screenInitialWidth = 0.0;
  static double screenInitialHeight = 0.0;

  static Future<void> setup(Widget main) async {
    await EasyLocalization.ensureInitialized();

    FlutlyConfig config = FlutlyConfig();
    await config.setup();
    Get.put(config);

    Get.put(FlutlyTheme());
    Get.put(FlutlyFonts());

    List<Locale> supportedLocales = getSupportedLocales();
    print("Desteklenen diller : " + supportedLocales.first.toString());
 
    runApp(
      EasyLocalization(
        supportedLocales: supportedLocales,
        path: config
            .getVariable("general")
            .getChild("translations_path")
            .getValue(),
        fallbackLocale: 'tr'.toLocale(),
        child: main,
      ),
    );
  }

  static void setLocale(BuildContext context, Locale locale){
    context.setLocale(locale);
  }

  static List<Locale> getSupportedLocales(){
    List<Locale> locales = List.empty(growable: true);

    FlutlyVariable variable = Get.find<FlutlyConfig>().getVariable("general").getChild("translations_list");
    return (variable.getValue() as YamlList).toList().map((e) => Locale(e)).toList();
  }

  static void screenConfiguration(BuildContext context) {
    if (screenInitialWidth != 0.0) return;

    screenInitialWidth = MediaQuery.sizeOf(context).width;
    screenInitialHeight = MediaQuery.sizeOf(context).height;
  }
}
