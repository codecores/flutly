import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_app_bar.dart';
import 'package:flutly/core/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_page.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/enums/theme_type.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutly/test/five_page.dart';
import 'package:flutly/test/four_page.dart';
import 'package:flutly/test/main_page.dart';
import 'package:flutly/test/other_page.dart';
import 'package:flutly/test/second_page.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutly/widgets/flutly_variable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutly/core/flutly_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: FlutlyAppBar(
        blured: false,
        color: Colors.black,
        animated: true,
      ),
      bottomBar: FlutlyBottomBar(
        height: 60,
        itemSize: 30,
        color: Colors.black,
        blured: true,
        items: [
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Home",
              path: "/",
              page: const MainPage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home_active.svg"),
            appBar: Container(
              width: 200,
              height: 50,
              color: Colors.red,
            ),
            appBarHeight: 100,
          ),
          FlutlyBottomBarItem(
              page: FlutlyPage(
                name: "Second",
                path: "/second",
                page: const SecondPage(),
              ),
              activePath:
                  SvgPicture.asset("assets/bottom_bar/home2_active.svg"),
              appBar: Container(
                width: 200,
                height: 50,
                color: Colors.green,
              ),
              appBarHeight: 130,
              children: [
                FlutlyBottomBarItem(
                  page: FlutlyPage(
                    name: "Second2",
                    path: "main",
                    page: const MainPage(),
                  ),
                  activePath:
                      SvgPicture.asset("assets/bottom_bar/home2_active.svg"),
                  appBar: Container(
                    width: 200,
                    height: 50,
                    color: Colors.yellow,
                  ),
                  appBarHeight: 50,
                ),
              ]),
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Four",
              path: "/four",
              page: const FourPage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home3_active.svg"),
            appBar: Container(
              width: 200,
              height: 50,
            ),
            appBarHeight: 30,
          ),
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Five",
              path: "/five",
              page: const FivePage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home4_active.svg"),
            appBar: Container(
              width: 200,
              height: 50,
              color: Colors.orange,
            ),
            appBarHeight: 300,
          ),
        ],
      ),
      pages: [
        FlutlyPage(
          name: "Other",
          path: "/other",
          page: const OtherPage(),
        ),
      ],
    );
  }
}
