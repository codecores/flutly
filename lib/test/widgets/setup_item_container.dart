import 'package:flutly/apperiances/flutly_profile_image_apperiances.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/test/widgets/SetupItem.dart';
import 'package:flutly/test/widgets/bordered_container.dart';
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutly/widgets/flutly_image.dart';
import 'package:flutly/widgets/flutly_profile_image.dart';
import 'package:flutly/widgets/flutly_stateless_widget.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetupItemContainer extends FlutlyStatelessWidget {
  SetupItem setupItem;
  SetupItemContainer({
    Key? key,
    required this.setupItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutlyButton(
      buttonType: ButtonType.BOUNCING,
      onTap: () {
        Flutly.go(context, "/marketplace/setup");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            BorderedContainer(
              width: double.infinity,
              height: 400,
              borderRadius: 28,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      Color.fromRGBO(14, 18, 27, 1.0),
                      Color.fromRGBO(24, 29, 38, 1.0),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SizedBox.expand(
                              child: Row(
                                children: [
                                  FlutlyProfileImage(
                                    path: setupItem.photo,
                                    width: 40,
                                    height: 40,
                                    apperiances: FlutlyProfileImageApperiances(
                                      borderWeight: 4,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  FlutlyText(
                                    setupItem.name,
                                    font: " text-medium textColor w400 ",
                                    shimmer: true,
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    "assets/bottom_bar/premium.png",
                                    width: 22,
                                    height: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            elevation: 0,
                            enableFeedback: false,
                            tooltip: "",
                            position: PopupMenuPosition.under,
                            offset: const Offset(-10, 10),
                            onOpened: () {
                              HapticFeedback.lightImpact();
                            },
                            onSelected: (value) {
                              HapticFeedback.selectionClick();
                            },
                            onCanceled: () {
                              HapticFeedback.selectionClick();
                            },
                            color: Flutly.getFlutlyTheme().getColor("soft200"),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Text("Subscribe"),
                              ),
                              const PopupMenuItem(
                                child: Text("Open notifications"),
                              ),
                              const PopupMenuItem(
                                child: Text("Share"),
                              ),
                            ],
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.topCenter,
                              child: FlutlyImage(
                                "assets/bottom_bar/menu_v2.png",
                                fit: BoxFit.contain,
                                shimmer: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //super.build(context),
          ],
        ),
      ),
    );
  }
}
