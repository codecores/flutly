import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_app.dart';
import 'package:flutly/core/flutly_app_bar/flutly_app_bar.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_page.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutly/test/five_page.dart';
import 'package:flutly/test/four_page.dart';
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

  @override
  Widget build(BuildContext context) {
    Flutly.screenConfiguration(context);
    
    return FlutlyApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      appBar: FlutlyAppBar(
        color: const Color.fromRGBO(16, 17, 16, 1),
      ),
      bottomBar: FlutlyBottomBar(
        height: 60,
        itemSize: 30,
        color: const Color.fromRGBO(16, 17, 16, 1),
        blur: 2.5,
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
                  appBarHeight: 80,
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
            appBarHeight: 0,
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
