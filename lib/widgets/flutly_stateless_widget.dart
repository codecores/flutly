import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

enum FlutlyShimmerType {CONTAINER, TEXT}

abstract class FlutlyStatelessWidget extends StatelessWidget {
  FlutlyShimmerType? type;
  bool? canShimmer;
  FlutlyStatelessWidget({Key? key}) : super(key: key);

  void setShimmerType(FlutlyShimmerType type){
    this.type = type;
  }

  void setCanShimmer(bool canShimmer){
    this.canShimmer = canShimmer;
  }

  @override
  Widget build(BuildContext context) {
    bool shimmerStatus = Flutly.getFlutlyConfig().onShimmer.value;

    if(canShimmer == null){
      return const SizedBox();
    }

    if(canShimmer != null){
      if(!canShimmer!){
        return const SizedBox();
      }
    }

    RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      return const SizedBox();
    }

    double height = renderBox.size.height;
    double borderRadius = 24;

    if(type != null){
      if(type == FlutlyShimmerType.TEXT){
        height = 14;
        borderRadius = 5;
      }
    }

    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(18, 22, 33, 1.0),
      highlightColor: const Color.fromRGBO(36, 41, 52, 1.0),
      child: Container(
        width: renderBox.size.width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    ).animate(target: shimmerStatus ? 0 : 1).fadeOut();
  }
}
