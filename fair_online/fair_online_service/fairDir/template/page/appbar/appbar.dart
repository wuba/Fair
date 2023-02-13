import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class @@PageName@@ extends StatefulWidget {
  const @@PageName@@({Key? key}) : super(key: key);

  @override
  State<@@PageName@@> createState() => _@@PageName@@State();
}

class _@@PageName@@State extends State<@@PageName@@> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('AppBar'),
        centerTitle: true,
        toolbarHeight: 55,
        primary: true,
        backgroundColor: Colors.blue,
        toolbarOpacity: 1,
        actions: [],
      ),
    );
  }
}
