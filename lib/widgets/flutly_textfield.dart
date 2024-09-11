import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class FlutlyTextfield extends StatefulWidget {
  Function(String)? onChanged;
  VoidCallback? onEditingComplete;
  VoidCallback? onTextfieldEmpty;
  double height;
  Widget leadingWidget;
  TextStyle textFieldStyle;
  BoxDecoration textFieldDecoration;
  InputDecoration inputDecoration;
  TextDirection direction;
  Widget clearButtonIcon;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;
  Color? cursorColor;
  bool? autofocus;
  bool? expanded;

  FlutlyTextfield({
    this.onTextfieldEmpty,
    this.height = 40,
    this.onChanged,
    this.onEditingComplete,
    this.cursorColor,
    this.autofocus,
    this.expanded,
    this.leadingWidget = const SizedBox.shrink(),
    this.textFieldStyle = const TextStyle(fontSize: 13),
    this.textFieldDecoration = const BoxDecoration(color: Color(0xffE8E8E8)),
    this.inputDecoration = const InputDecoration.collapsed(
      hintText: 'Enter Your Text Here',
      hintStyle: TextStyle(fontSize: 13, color: Color(0xffaeaeae)),
    ),
    this.clearButtonIcon =
        const Icon(Icons.clear_rounded, color: Color(0xffaeaeae), size: 20),
    this.direction = TextDirection.ltr,
    this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    super.key,
  });

  @override
  State<FlutlyTextfield> createState() => _FlutlyTextfieldState();
}

class _FlutlyTextfieldState extends State<FlutlyTextfield> {
  late StreamController<bool> _btnClearController;
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _btnClearController = StreamController<bool>();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _btnClearController.close();
    _inputController.dispose();
    super.dispose();
  }

  check(String text) {
    if (text.isNotEmpty) {
      _btnClearController.add(true);
    } else {
      _btnClearController.add(false);
      if (widget.onTextfieldEmpty != null) {
        widget.onTextfieldEmpty!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.direction,
      child: Container(
        height: widget.height,
        decoration: widget.textFieldDecoration,
        padding: widget.padding,
        margin: widget.margin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.leadingWidget,
            const SizedBox(width: 5),
            Expanded(
              child: TextFormField(
                controller: _inputController,
                onChanged: (value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                  check(value);
                },
                onEditingComplete: (){
                  if (widget.onEditingComplete != null) widget.onEditingComplete!();
                },
                cursorColor: widget.cursorColor,
                autofocus: widget.autofocus ?? false,
                decoration: widget.inputDecoration,
                style: widget.textFieldStyle,
                expands: widget.expanded ?? false,
                maxLines: null,
                minLines: null,
              ),
            ),
            StreamBuilder<bool>(
                stream: _btnClearController.stream,
                builder: (context, snapshot) {
                  return snapshot.data == true
                      ? GestureDetector(
                          onTap: () {
                            _inputController.clear();
                            _btnClearController.add(false);
                            if (widget.onTextfieldEmpty != null) {
                              widget.onTextfieldEmpty!();
                            }
                          },
                          child: widget.clearButtonIcon)
                      : const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
