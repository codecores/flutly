import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class BorderedContainer extends StatelessWidget {
  Widget child;
  double? width, height;
  double? borderRadius;
  Color? color;

  BorderedContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key) {
    borderRadius ??= 12;
  }

  LinearGradient gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color.fromRGBO(153, 160, 174, 0.24),
      Color.fromRGBO(153, 160, 174, 0.10),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
        gradient: gradient,
      ),
      padding: const EdgeInsets.all(1.1),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius! - 1)),
          color: Flutly.getFlutlyTheme().getColor("backgroundColor"),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius! - 5)),
            gradient: gradient,
          ),
          padding: const EdgeInsets.all(1.1),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius! - 5.5)),
              color: Flutly.getFlutlyTheme().getColor("backgroundColor"),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius! - 5)),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
