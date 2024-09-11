import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutly/widgets/flutly_variable_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutlyText(
              tr('general.title'),
              font: "large w500 subTextColor normal ml-1 center clip",
            ),
            FlutlyText(
              tr('general.description'),
              font: "medium w700 textColor italic",
            ),
            GestureDetector(
              onTap: () => context.go("/"),
              child: Container(
                width: 100,
                height: 40,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
