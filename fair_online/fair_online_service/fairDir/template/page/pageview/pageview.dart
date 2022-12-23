import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class @@PageName@@ extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _@@PageName@@State();
}

class _@@PageName@@State extends State<@@PageName@@> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PageView模版'),
        ),
        body: PageView.builder(
          itemBuilder: _itemBuilder,
          itemCount: 3,
        ));
  }

  Widget _itemBuilder(context, index) {
    return Container(
      color: Colors.green,
      width: 100,
      height: 100,
      child: Text('第$index页'),
    );
  }
}
