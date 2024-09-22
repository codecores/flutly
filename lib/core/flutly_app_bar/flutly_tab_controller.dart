import 'package:flutly/core/flutly_app_bar/flutly_tab_view_controller.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_variable.dart';
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutlyTabController extends StatefulWidget {
  FlutlyTabViewController viewController;
  Widget child;
  FlutlyTabController({
    Key? key,
    required this.viewController,
    required this.child,
  }) : super(key: key);

  @override
  _FlutlyTabControllerState createState() => _FlutlyTabControllerState();
}

class _FlutlyTabControllerState extends State<FlutlyTabController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.viewController.length,
      animationDuration: widget.viewController.animationDuration,
      initialIndex: widget.viewController.initalIndex!,
      vsync: this,
    );
    
    print("TAB CONTROLLER OLUŞTURULDU");
    if(!Get.isRegistered(tag: "tab_controller")){
      FlutlyVariable variable = FlutlyVariable("tab_controller", _tabController);
      print("TAB CONTROLLER KAYIT EDİLDİ");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
