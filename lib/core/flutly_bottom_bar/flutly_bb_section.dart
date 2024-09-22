import 'package:blur/blur.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class FlutlyBbSection extends StatelessWidget {
  FlutlyBottomBar bottomBar;
  FlutlyBbSection({Key? key, required this.bottomBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: bottomBar.getBarHeight(),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: bottomBar.getLeadingHeight(),
            child: bottomBar.leading,
          ),
          Container(
            width: double.infinity,
            height: bottomBar.getHeight(),
            color: bottomBar.blur == null ? bottomBar.getColor(context) : null,
            child: Stack(
              children: [
                bottomBar.blur != null ?
                Blur(
                  blur: bottomBar.blur!,
                  blurColor: bottomBar.getColor(context),
                  child: const SizedBox.expand(),
                ) : const SizedBox(),
                SafeArea(
                  child: Column(
                    children: [
                      bottomBar.separator != null
                          ? SizedBox(
                              width: double.infinity,
                              child: bottomBar.separator!,
                            )
                          : const SizedBox(),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < bottomBar.items.length; i++)
                              GestureDetector(
                                onTap: () {
                                  if (bottomBar.items[i].page.path !=
                                      Get.find<FlutlyConfig>()
                                          .getCurrentRoute()) {
                                    context.go(bottomBar.items[i].page.path);
                                  }
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: double.infinity,
                                  child: Center(
                                    child: SizedBox(
                                      width: bottomBar.itemSize ?? 30,
                                      height: bottomBar.itemSize ?? 30,
                                      child: bottomBar.items[i].activePath,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
