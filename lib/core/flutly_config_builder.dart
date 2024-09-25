import 'package:flutly/core/flutly_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyConfigBuilder extends StatelessWidget {
  final Widget Function(FlutlyConfig) builder;

  FlutlyConfigBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlutlyConfig>(
      builder: builder,
    );
  }
}
