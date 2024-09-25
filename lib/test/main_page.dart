import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/apperiances/flutly_dialog_apperiances.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_tab_controller.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/enums/dialog_type.dart';
import 'package:flutly/external/modal_bottom_sheet/src/bottom_sheets/material_bottom_sheet.dart';
import 'package:flutly/external/modal_bottom_sheet/src/utils/modal_scroll_controller.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/test/sheets/order_sheet.dart';
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
        child: TabBarView(
          controller:
              Flutly.getFlutlyVariable(tag: "main_tab_controller").getValue(),
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
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
                    FlutlyButton(
                      buttonType: ButtonType.BOUNCING,
                      onTap: () {
                        Flutly.closeBottomBar();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                      ),
                    ),
                    FlutlyButton(
                      buttonType: ButtonType.BOUNCING,
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: const OrderSheet(),
                          ),
                          blur: 10,
                          blurColor: const Color.fromRGBO(255, 255, 255, 0.10),
                          useRootNavigator: true,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
