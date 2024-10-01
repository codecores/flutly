import 'package:blur/blur.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlutlyBluredDialog extends StatelessWidget {
  Widget child;
  FlutlyBluredDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FlutlyButton(
      buttonType: ButtonType.G_DEDECTOR,
      onTap: () {
        Flutly.pop(context);
      },
      child: SizedBox.expand(
        child: Stack(
          children: [
            const Blur(
              blur: 10,
              blurColor: Color.fromRGBO(14, 18, 27, 0.24),
              child: SizedBox.expand(),
            ),
            SizedBox.expand(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
