import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class UrlLauncherPage extends StatefulWidget {
  Map<String, dynamic> params;
  UrlLauncherPage({Key key, this.params}) : super(key: key);

  @override
  _UrlLauncherPageState createState() {
    return _UrlLauncherPageState();
  }
}

class _UrlLauncherPageState extends State<UrlLauncherPage> {
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
      name: "url_launcher",
      path: "assets/bundle/lib_url_launcher_fair_url_launcher_widget.fair.json",
      data: {
        'title': "url launcher Demo Page"
      },
    );
  }
}