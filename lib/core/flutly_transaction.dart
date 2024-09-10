import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlutlyTransaction {
  static Page<dynamic> getDefaultTransaction(LocalKey key, Widget widget) {
    return CustomTransitionPage<void>(
      key: key,
      child: widget,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final reverseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeOutQuart,
          ),
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCirc,
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: reverseAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
