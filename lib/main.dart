import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/enums/theme_type.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutly/widgets/flutly_variable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutly/widgets/flutly_app.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flutly.setup(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void test(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Flutly.setLocale(context, const Locale("tr"));
  }

  @override
  Widget build(BuildContext context) {
    Flutly.screenConfiguration(context);
    test(context);

    return FlutlyApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

