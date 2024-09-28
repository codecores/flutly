library flutly;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/external/fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import 'package:yaml/yaml.dart';

import 'package:flutly/apperiances/flutly_dialog_apperiances.dart';
import 'package:flutly/apperiances/flutly_toast_apperiances.dart';
import 'package:flutly/apperiances/flutly_button_apperiances.dart';

import 'package:flutly/core/flutly_bottom_bar/flutly_bb_section.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bottom_bar.dart';

import 'package:flutly/core/flutly_app_bar/flutly_ab_section.dart';
import 'package:flutly/core/flutly_app_bar/flutly_app_bar.dart';

import 'package:flutly/core/flutly_app.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/core/flutly_font.dart';
import 'package:flutly/core/flutly_fonts.dart';
import 'package:flutly/core/flutly_page.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/core/flutly_transaction.dart';

import 'package:flutly/enums/button_type.dart';
import 'package:flutly/enums/dialog_type.dart';
import 'package:flutly/enums/theme_type.dart';

import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutly/models/flutly_variable.dart';

import 'package:flutly/utilities/flutly_utilities.dart';

import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutly/widgets/flutly_dialog.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutly/widgets/flutly_textfield.dart';
import 'package:flutly/widgets/flutly_variable_text.dart';

class Flutly {
  static double screenInitialWidth = 0.0;
  static double screenInitialHeight = 0.0;

  static Future<void> setup(YamlMap configYaml, Widget main) async {
    await EasyLocalization.ensureInitialized();

    FlutlyConfig config = FlutlyConfig();
    await config.setup(configYaml);
    Get.put(config);

    Get.put(FlutlyTheme());
    Get.put(FlutlyFonts());

    List<Locale> supportedLocales = getSupportedLocales();

    runApp(
      EasyLocalization(
        supportedLocales: supportedLocales,
        path: config
            .getVariable("general")
            .getChild("translations_path")
            .getValue(),
        fallbackLocale: const Locale("tr"),
        child: main,
      ),
    );
  }

  static FlutlyFonts getFlutlyFonts() => Get.find<FlutlyFonts>();

  static FlutlyTheme getFlutlyTheme() => Get.find<FlutlyTheme>();

  static FlutlyConfig getFlutlyConfig() => Get.find<FlutlyConfig>();

  static FlutlyVariable getFlutlyVariable({String? tag}) =>
      Get.find<FlutlyVariable>(tag: tag);

  static void put<S>(S dependency,
          {String? tag,
          bool permanent = false,
          InstanceBuilderCallback<S>? builder}) =>
      Get.put(dependency, tag: tag, permanent: permanent, builder: builder);

  static void putAsync<S>(AsyncInstanceBuilderCallback<S> builder,
          {String? tag, bool permanent = false}) =>
      Get.putAsync(builder, tag: tag, permanent: permanent);

  static void changeTheme(ThemeType themeType) {
    Get.find<FlutlyTheme>().changeTheme(themeType);
  }

  static void setLocale(BuildContext context, Locale locale) {
    context.setLocale(locale);
  }

  static List<Locale> getSupportedLocales() {
    List<Locale> locales = List.empty(growable: true);

    FlutlyVariable variable = Get.find<FlutlyConfig>()
        .getVariable("general")
        .getChild("translations_list");
    return (variable.getValue() as YamlList)
        .toList()
        .map((e) => Locale(e))
        .toList();
  }

  static void screenConfiguration(BuildContext context) {
    if (screenInitialWidth != 0.0) return;

    screenInitialWidth = MediaQuery.sizeOf(context).width;
    screenInitialHeight = MediaQuery.sizeOf(context).height;
  }

  static void go(BuildContext context, String location, {Object? extra}) {
    context.go(location, extra: extra);
  }

  static void goNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    context.goNamed(name,
        extra: extra,
        pathParameters: pathParameters,
        queryParameters: queryParameters);
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    context.pop(result);
  }

  static void openBottomBar() => getFlutlyConfig().setBottomBarHidden(false);
  static void closeBottomBar() => getFlutlyConfig().setBottomBarHidden(true);

  static showToast({
    required Duration duration,
    Widget? widget,
    String? text,
    FlutlyToastApperiances? apperiances,
  }) {
    if (widget == null && text == null) {
      throw ("'child' and 'text' cannot be null at the same time. Please define child or apperiances parameters.");
    }
    apperiances ??= FlutlyToastApperiances(
        backgroundColor: Get.find<FlutlyTheme>().getColor("buttonColor"),
        borderRadius: 8,
        textFC: "small textColor normal");

    HapticFeedback.mediumImpact();

    var fToast = FToast();
    fToast.init(Get.find<FlutlyConfig>().context!);
    fToast.showToast(
      toastDuration: duration,
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.infinity,
        height: 60,
        constraints: const BoxConstraints(maxHeight: 100),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: apperiances.backgroundColor,
          borderRadius: BorderRadius.circular(apperiances.borderRadius!),
          //boxShadow: UtilColor.getBoxShadow2,
        ),
        child: widget ??
            Center(
              child: FlutlyText(
                text!,
                font: apperiances.textFC!,
              ),
            ),
      ),
    );
  }

  static void showDialog(BuildContext context,
      {required FlutlyDialogApperiances apperiances}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return FlutlyDialog(apperiances: apperiances);
      },
      transitionBuilder: (_, anim, __, child) {
        Animation<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(
            CurvedAnimation(
              parent: anim,
              curve: Curves.easeOutCirc,
            ),
          );
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
              parent: anim,
              curve: Curves.easeOutCirc,
            ),
          );
        }

        return SlideTransition(
          position: tween,
          child: child,
        );
      },
    );
  }

  static void vibrate({
    int duration = 500,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) async {
    bool? hasVibration = await Vibration.hasVibrator();
    if (hasVibration == null) return;
    if (!hasVibration) return;

    Vibration.vibrate(amplitude: amplitude, duration: duration, intensities: intensities, pattern: pattern, repeat: repeat);
  }
}
