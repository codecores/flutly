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
    return Container(
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
          FlutlyButton(
            text: "Naber",
            buttonType: ButtonType.BOUNCING,
            onTap: () {
              // Flutly.showDialog(
              //   context,
              //   apperiances: FlutlyDialogApperiances(
              //     dialogType: DialogType.SURE,
              //     backgroundColor: const Color.fromARGB(255, 34, 33, 33),
              //     title: FlutlyText("Başlık", font: "small textColor normal"),
              //     description:
              //         FlutlyText("Başlık", font: "small textColor normal"),
              //     left: FlutlyDialogActionApperiances(
              //       buttonTitle:
              //           FlutlyText("Evet", font: "small textColor normal"),
              //       buttonTap: () {
              //         Flutly.showToast(duration: const Duration(seconds: 2), text: "Masd");
              //       },
              //       buttonColor: Colors.red,
              //     ),
              //     right: FlutlyDialogActionApperiances(
              //       buttonTitle:
              //           FlutlyText("No", font: "small textColor normal"),
              //       buttonTap: () {
              //         context.pop();
              //       },
              //       buttonColor: Colors.green,
              //     ),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
