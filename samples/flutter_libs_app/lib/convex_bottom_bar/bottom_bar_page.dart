import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class BottomBarPage extends StatefulWidget {
  BottomBarPage({Key? key}) : super(key: key);

  @override
  _BottomBarPageState createState() {
    return _BottomBarPageState();
  }
}

class _BottomBarPageState extends State<BottomBarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FairWidget(
      name: "bottom_bar",
      path: "assets/bundle/lib_convex_bottom_bar_bottom_bar_widget.fair.json",
      data: {
        'title': "Bottom Bar Demo Page"
      },
    );
  }
}