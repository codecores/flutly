import 'package:flutly/core/flutly_builder.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutlyBuilder<FlutlyVariable>(
      tag: "main_tab_controller",
      builder: (controller) {
        TabController tabController = controller.getValue();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: TabBar(
              controller: tabController,
              onTap: (value) {
                controller.update();
              },
              tabs: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Flutly.getFlutlyTheme().getColor("backgroundColor"),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Center(
                    child: FlutlyText("Setups",
                        font:
                            " medium normal ${tabController.index == 0 ? " textColor " : " soft400 "}"),
                  ),
                ),
                SizedBox.expand(
                  child: Center(
                    child: FlutlyText("Watchlist",
                        font:
                            " medium normal ${tabController.index == 1 ? " textColor " : " soft400 "}"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
