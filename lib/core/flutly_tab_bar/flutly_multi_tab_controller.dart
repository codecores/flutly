import 'package:flutly/core/flutly_tab_bar/flutly_tab_controller.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_tab_view_controller.dart';
import 'package:flutter/material.dart';

class FlutlyMultiTabController extends StatelessWidget {
  final Widget child;
  final List<FlutlyTabViewController> controllers;

  const FlutlyMultiTabController({
    Key? key,
    required this.child,
    required this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...controllers.map((e) => FlutlyTabController(
              tag: e.tag,
              child: const SizedBox(),
            )),
        child
      ],
    );
  }
}
