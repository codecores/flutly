import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 100,
              color: Colors.yellow,
            ),
            FlutlyText(
              tr('general.title'),
              font: "large w500 subTextColor normal ml-1 center clip",
            ),
            FlutlyText(
              tr('general.description'),
              font: "medium w700 textColor italic",
            ),
            GestureDetector(
              onTap: () => context.go("/second/main"),
              child: Container(
                width: 100,
                height: 40,
                margin: const EdgeInsets.only(top: 10),
                color: Colors.green,
              ),
            ),
            const SizedBox(width: double.infinity, height: 1000),
          ],
        ),
      ),
    );
  }
}
