import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleWanAndroidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FairWidget(
        name: 'hello_world2',
        path: 'assets/bundle/lib_src_page_hello_world.fair.bin',
      ),
    );
  }
}
