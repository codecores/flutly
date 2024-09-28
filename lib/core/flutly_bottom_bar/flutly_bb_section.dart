import 'package:blur/blur.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/enums/button_type.dart';
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FlutlyBbSection extends StatefulWidget {
  FlutlyBottomBar bottomBar;
  FlutlyBbSection({Key? key, required this.bottomBar}) : super(key: key);

  @override
  _FlutlyBbSectionState createState() => _FlutlyBbSectionState();
}

class _FlutlyBbSectionState extends State<FlutlyBbSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlutlyConfig>(
      builder: (controller) {
        if (controller.bottomBarHidden) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        return SlideTransition(
          position: _animation,
          child: SizedBox(
            width: double.infinity,
            height: widget.bottomBar.getBarHeight() +
                MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: widget.bottomBar.getLeadingHeight(),
                  child: widget.bottomBar.leading,
                ),
                Container(
                  width: double.infinity,
                  height: widget.bottomBar.getHeight() +
                      MediaQuery.of(context).padding.bottom,
                  color: widget.bottomBar.blur == null
                      ? widget.bottomBar.getColor(context)
                      : null,
                  child: Stack(
                    children: [
                      widget.bottomBar.blur != null
                          ? Blur(
                              blur: widget.bottomBar.blur!,
                              blurColor: widget.bottomBar.getColor(context),
                              child: const SizedBox.expand(),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: double.infinity,
                        height: widget.bottomBar.getHeight(),
                        child: Column(
                          children: [
                            widget.bottomBar.separator != null
                                ? SizedBox(
                                    width: double.infinity,
                                    child: widget.bottomBar.separator!,
                                  )
                                : const SizedBox(),
                            Flexible(
                              child: SizedBox.expand(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0;
                                        i < widget.bottomBar.items.length;
                                        i++)
                                      Flexible(
                                        child: FlutlyButton(
                                          buttonType: ButtonType.BOUNCING,
                                          onTap: () {
                                            if (widget.bottomBar.items[i].page
                                                    .path !=
                                                Get.find<FlutlyConfig>()
                                                    .getCurrentRoute()) {
                                              context.go(widget.bottomBar
                                                  .items[i].page.path);
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.transparent,
                                            child: Center(
                                              child: SizedBox(
                                                width:
                                                    widget.bottomBar.itemSize ??
                                                        30,
                                                height:
                                                    widget.bottomBar.itemSize ??
                                                        30,
                                                child: widget.bottomBar.items[i]
                                                    .activePath,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
