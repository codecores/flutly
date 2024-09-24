import 'package:flutly/core/flutly_tab_bar/flutly_tab_view_controller.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutly/utilities/vsync_provider.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyTabController extends StatelessWidget {
  String tag;
  Widget child;
  FlutlyTabController({
    Key? key,
    required this.tag,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VsyncProvider(
      key: UniqueKey(),
      builder: (vsync) {
        FlutlyTabViewController? viewController = Flutly.getFlutlyConfig()
            .tabBars
            .firstWhereOrNull((element) => tag == element.tag);

        if (viewController != null) {
          final tabController = TabController(
            length: viewController.length,
            animationDuration: viewController.animationDuration,
            initialIndex: viewController.initalIndex!,
            vsync: vsync,
          );

          if (!Get.isRegistered(tag: viewController.tag)) {
            FlutlyVariable variable =
                FlutlyVariable(viewController.tag, tabController);
          }
        }

        return child;
      },
    );
  }
}
