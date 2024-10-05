import 'package:flutly/core/flutly_config_builder.dart';
import 'package:flutly/widgets/flutly_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlutlyImage extends FlutlyStatelessWidget {
  String path;
  bool? shimmer;
  BoxFit? fit;
  FlutlyImage(
    this.path, {
    Key? key,
    this.fit,
    this.shimmer,
  }) : super(key: key) {
    shimmer ??= false;
    setCanShimmer(shimmer!);
  }

  @override
  Widget build(BuildContext context) {
    return FlutlyConfigBuilder(
      builder: (controller) {
        return Stack(
          children: [
            Image.asset(path, fit: fit)
                .animate(target: shimmer! ? (controller.onShimmer.value ? 0 : 1) : 1)
                .fadeIn(),
            super.build(context),
          ],
        );
      },
    );
  }
}
