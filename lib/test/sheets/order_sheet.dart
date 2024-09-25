import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';

class OrderSheet extends StatelessWidget {
  const OrderSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        color: Flutly.getFlutlyTheme().getColor("backgroundColor"),
      ),
    );
  }
}
