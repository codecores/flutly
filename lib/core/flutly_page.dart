import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlutlyPage {
  String name;
  String path;
  Widget page;
  FutureOr<bool> Function(BuildContext, GoRouterState)? onExit;

  FlutlyPage({
    required this.name,
    required this.path,
    required this.page,
    this.onExit,
  });
}
