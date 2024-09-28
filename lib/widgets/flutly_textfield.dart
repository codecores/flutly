import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class FlutlyTextfield extends StatefulWidget {
  Function(String)? onChanged;
  VoidCallback? onEditingComplete;
  VoidCallback? onTextfieldEmpty;
  VoidCallback? onFocus;
  VoidCallback? onUnfocus;
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
  TextEditingController? controller;
  FocusNode? focusNode;

  FlutlyTextfield({
    this.onTextfieldEmpty,
    this.height = 40,
    this.onChanged,
    this.onEditingComplete,
    this.cursorColor,
    this.autofocus,
    this.expanded,
    this.onFocus,
    this.onUnfocus,
    this.controller,
    this.focusNode,
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
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _btnClearController = StreamController<bool>();
    _inputController = widget.controller ?? TextEditingController();
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _btnClearController.close();
    _inputController.dispose();
    _focus.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    bool oldState = Flutly.getFlutlyConfig().keyboardShowing;
    bool newState = _focus.hasFocus;

    if(oldState == newState) return;
    
    if(newState) {
      if(widget.onFocus != null) widget.onFocus!();
    }else{
      if(widget.onUnfocus != null) widget.onUnfocus!();
    }
    Flutly.getFlutlyConfig().setKeyboardShowing(_focus.hasFocus);
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
                focusNode: _focus,
                onChanged: (value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                  check(value);
                },
                onEditingComplete: () {
                  if (widget.onEditingComplete != null)
                    widget.onEditingComplete!();
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
                            FocusScope.of(context).unfocus();
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
