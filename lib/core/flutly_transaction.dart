import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlutlyTransaction {
  static Page<dynamic> getDefaultTransaction(LocalKey key, Widget widget) {
    return CustomTransitionPage<void>(
      key: key,
      child: widget,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final reverseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
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
            reverseCurve: Curves.easeIn
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

  static Page<dynamic> getFadeTransaction(LocalKey key, Widget widget) {
    return CustomTransitionPage<void>(
      key: key,
      child: widget,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 50),
      reverseTransitionDuration:
          const Duration(milliseconds: 0), // Kapanış animasyonu yok
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        // Açılış animasyonu: opacity artışı (FadeTransition)
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut, // Yumuşak geçiş
          ),
        );

        // Sadece FadeTransition uygulanacak
        return FadeTransition(
          opacity: fadeAnimation, // Opacity artışı ile açılış
          child: child,
        );
      },
    );
  }
}
