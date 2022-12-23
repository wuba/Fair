import 'package:flutter/material.dart';

class PageMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageMainPageState();
  }
}

class PageMainPageState extends State<PageMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
