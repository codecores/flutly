import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_app.dart';
import 'package:flutly/core/flutly_app_bar/flutly_app_bar.dart';
import 'package:flutly/core/flutly_app_bar/flutly_app_bar_item.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_tab_view_controller.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_page.dart';
import 'package:flutly/enums/theme_type.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutly/test/five_page.dart';
import 'package:flutly/test/four_page.dart';
import 'package:flutly/test/main_app_bar.dart';
import 'package:flutly/test/main_page.dart';
import 'package:flutly/test/other_page.dart';
import 'package:flutly/test/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaml/yaml.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final yamlString = await rootBundle.loadString('assets/config.yaml');
  YamlMap yamlData = loadYaml(yamlString);

  await Flutly.setup(yamlData, const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void test(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Flutly.getFlutlyConfig().setOnShimmer(false);
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
      tabBars: [
        FlutlyTabViewController(
          tag: "main_tab_controller",
          length: 2,
        ),
      ],
      appBar: FlutlyAppBar(
        bars: [
          FlutlyAppBarItem(
            name: "Home",
            appBar: const MainAppBar(),
            appBarHeight: 70,
            appBarAnimated: true,
          ),
          FlutlyAppBarItem(
            name: "Second",
            appBar: Container(
              width: 200,
              height: 50,
              color: Colors.green,
            ),
            appBarHeight: 130,
            appBarAnimated: true,
          ),
          FlutlyAppBarItem(
            name: "Second2",
            appBar: Container(
              width: 200,
              height: 50,
              color: Colors.yellow,
            ),
            appBarHeight: 80,
          ),
          FlutlyAppBarItem(
            name: "Four",
            appBar: const SizedBox(width: 200, height: 50),
            appBarAnimated: false,
            appBarHeight: 0,
          ),
          FlutlyAppBarItem(
            name: "Five",
            appBar: Container(
              width: 200,
              height: 50,
              color: Colors.orange,
            ),
            appBarHeight: 300,
            appBarAnimated: true,
          ),
        ],
      ),
      bottomBar: FlutlyBottomBar(
        height: 70,
        itemSize: 30,
        separator: Container(
          height: 0.5,
          color: Colors.grey,
        ),
        blur: 10,
        color: const Color.fromRGBO(14, 18, 27, 0.24),
        items: [
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Home",
              path: "/",
              page: const MainPage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home_active.svg"),
          ),
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Second",
              path: "/second",
              page: const SecondPage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home2_active.svg"),
            children: [
              FlutlyBottomBarItem(
                page: FlutlyPage(
                  name: "Second2",
                  path: "main",
                  page: const MainPage(),
                ),
                transactionType: FlutlyTransactionType.DEFAULT,
              ),
            ],
          ),
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Four",
              path: "/four",
              page: const FourPage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home3_active.svg"),
          ),
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Five",
              path: "/five",
              page: const FivePage(),
            ),
            activePath: SvgPicture.asset("assets/bottom_bar/home4_active.svg"),
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
