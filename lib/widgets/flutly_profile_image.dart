import 'package:flutly/apperiances/flutly_profile_image_apperiances.dart';
import 'package:flutly/core/flutly_config_builder.dart';
import 'package:flutly/widgets/flutly_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlutlyProfileImage extends FlutlyStatelessWidget {
  String path;
  double? width;
  double? height;
  bool? expanded;
  FlutlyProfileImageApperiances? apperiances;
  FlutlyProfileImage({
    Key? key,
    required this.path,
    this.apperiances,
    this.width,
    this.height,
    this.expanded,
  }) : super(key: key) {
    apperiances ??= FlutlyProfileImageApperiances();
    setCanShimmer(true);
  }

  @override
  Widget build(BuildContext context) {
    if ((width == null || height == null) && expanded == null) {
      throw ("The values ​​of Width and Height or expanded values ​​are required.");
    }

    if (expanded ?? false) {
      return Expanded(child: getContent(context));
    }
    return getContent(context);
  }

  Widget getContent(BuildContext context) {
    bool isExpanded = (expanded ?? false);
    bool isNetworkImage = path.startsWith("http");

    return FlutlyConfigBuilder(
      builder: (controller) {
        return Stack(
          children: [
            Container(
              width: isExpanded ? double.infinity : width,
              height: isExpanded ? double.infinity : height,
              decoration: BoxDecoration(
                borderRadius: apperiances!.getBorderRadius(),
                shape: apperiances!.borderRadius == null
                    ? apperiances!.shape!
                    : BoxShape.rectangle,
                border: Border.all(
                  color: apperiances!.borderColor!,
                  width: apperiances!.borderWeight!,
                ),
              ),
              child: ClipRRect(
                borderRadius: apperiances!.getBorderRadius() ??
                    const BorderRadius.all(Radius.circular(999)),
                child: isNetworkImage ? Image.network(path) : Image.asset(path),
              ),
            ).animate(target: controller.onShimmer.value ? 0 : 1).fadeIn(),
            super.build(context),
          ],
        );
      },
    );
  }
}
