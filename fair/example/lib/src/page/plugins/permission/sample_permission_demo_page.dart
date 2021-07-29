import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 相机，权限demo
class PermissionSamplePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PermissionSamplePageState();
}

class PermissionSamplePageState extends State<PermissionSamplePage> {
  @override
  Widget build(BuildContext context) {
    return FairWidget(
      name: 'PermissionSamplePage',
      path: 'assets/bundle/lib_src_page_plugins_permission_sample_permission_page.fair.json',
    );
  }
}
