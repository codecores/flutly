import 'package:flutter/material.dart';

/// Bu widget, TickerProviderStateMixin kullanarak vsync sağlar
class VsyncProvider extends StatefulWidget {
  final Widget Function(TickerProvider vsync) builder;

  const VsyncProvider({Key? key, required this.builder}) : super(key: key);

  @override
  _VsyncProviderState createState() => _VsyncProviderState();
}

class _VsyncProviderState extends State<VsyncProvider>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // vsync'yi dışarıya sağlayacak şekilde widget'ı oluşturuyoruz
    return widget.builder(this);
  }
}
