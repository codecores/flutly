import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlutlyApp extends StatelessWidget {
  Widget app;
  FlutlyApp({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(Flutly.screenInitialWidth, Flutly.screenInitialHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return child ?? const SizedBox();
      },
      child: app,
    );
  }
}
