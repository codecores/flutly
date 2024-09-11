import 'package:flutly/apperiances/flutly_dialog_apperiances.dart';
import 'package:flutly/apperiances/flutly_button_apperiances.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlutlyDialog extends StatelessWidget {
  FlutlyDialogApperiances apperiances;
  FlutlyDialog({super.key, required this.apperiances});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: apperiances.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              apperiances.title,
              const SizedBox(height: 10),
              apperiances.description,
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    apperiances.left != null ?
                    FlutlyButton(
                      buttonType: ButtonType.BOUNCING,
                      onTap: () {
                        apperiances.left!.buttonTap();
                      },
                      apperiances: FlutlyButtonApperiances(
                        expanded: true,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        color: apperiances.left!.buttonColor,
                        child: apperiances.left!.buttonTitle,
                      ),
                    ) : const SizedBox(),
                     SizedBox(width: apperiances.right != null ? 10 : 0),
                    apperiances.right != null ?
                    FlutlyButton(
                      buttonType: ButtonType.BOUNCING,
                      onTap: () {
                        apperiances.right!.buttonTap();
                      },
                      apperiances: FlutlyButtonApperiances(
                        expanded: true,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        color: apperiances.right!.buttonColor,
                        child: apperiances.right!.buttonTitle,
                      ),
                    ) : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
