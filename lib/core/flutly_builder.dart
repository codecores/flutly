import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyBuilder<T extends GetxController> extends StatelessWidget {
  final Widget Function(T) builder;
  final String tag;

  FlutlyBuilder({
    Key? key,
    required this.tag,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      tag: tag,
      builder: builder,
    );
  }
}
