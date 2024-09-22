import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutly/widgets/flutly_textfield.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FlutlyTextfield(
                  height: 50,
                  textFieldDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 31, 31, 31),
                  ),
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for your favoutie Anime',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  textFieldStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  expanded: false,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
