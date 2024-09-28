import 'dart:ui';

import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';

class FlutlyProfileImageApperiances {
  Color? borderColor;
  double? borderRadius;
  double? borderWeight;
  BoxShape? shape;

  FlutlyProfileImageApperiances({
    this.borderColor,
    this.borderRadius,
    this.borderWeight,
    this.shape,
  }) {
    borderColor ??= Flutly.getFlutlyTheme().getColor("secondaryBackgroundColor");
    borderWeight ??= 2;
    shape ??= BoxShape.circle;
  }

  BorderRadius? getBorderRadius() => borderRadius != null ? BorderRadius.all(Radius.circular(borderRadius!)) : null;
}