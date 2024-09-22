import 'package:flutly/flutly.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TabBar(
          tabs: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Flutly.getFlutlyTheme().getColor("backgroundColor"),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Center(
                child: FlutlyText("Setups", font: "medium textColor normal"),
              ),
            ),
            SizedBox.expand(
              child: Center(
                child: FlutlyText("Watchlist", font: "medium soft400 normal"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
