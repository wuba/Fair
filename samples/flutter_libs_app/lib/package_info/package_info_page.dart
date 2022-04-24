import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class PackageInfoPage extends StatefulWidget {
  Map<String, dynamic>? params;

  PackageInfoPage({Key? key, this.params}) : super(key: key);

  @override
  _PackageInfoPageState createState() {
    return _PackageInfoPageState();
  }
}

class _PackageInfoPageState extends State<PackageInfoPage> {

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
      name: "package_info",
      path: "assets/bundle/lib_package_info_fair_package_info_widget.fair.json",
      data: {
        'title': "Package Info Demo Page"
      },
    );
  }
}