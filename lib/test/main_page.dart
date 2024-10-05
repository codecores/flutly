import 'package:flutly/apperiances/flutly_profile_image_apperiances.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/test/widgets/SetupItem.dart';
import 'package:flutly/test/widgets/setup_item_container.dart';
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutly/widgets/flutly_profile_image.dart';
import 'package:flutly/widgets/flutly_rich_text.dart';
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
          physics: const NeverScrollableScrollPhysics(),
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
                        onFocus: () {
                          print("KLAVYE : FOCUS OLDU");
                        },
                        onUnfocus: () {
                          print("KLAVYE : FOCUS DIŞI OLDU");
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SetupItemContainer(
                        setupItem: SetupItem(
                          "assets/bottom_bar/profile_photo.jpeg",
                          "Matthew Johnson",
                        ),
                      ),
                      const SizedBox(height: 10),
                      SetupItemContainer(
                        setupItem: SetupItem(
                          "assets/bottom_bar/profile_photo.jpeg",
                          "Matthew Johnson",
                        ),
                      ),
                    FlutlyRichText(
                      font: " large ",
                      texts: [
                        FlutlyText("Selamlar", font: " textColor w700 "),
                        FlutlyText("Naber", font: " subTextColor "),
                      ],
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

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(
                  MaterialPageRoute<SecondRoute>(
                    builder: (context) => SecondRoute(),
                  ),
                );
            },
            child: Container(
              height: 50,
              color: Colors.amber[100],
              child: const Center(child: Text('Entry A')),
            ),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[200],
            child: const Center(child: Text('Entry B')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[300],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
