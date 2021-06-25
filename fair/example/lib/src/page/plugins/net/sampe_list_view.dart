import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleWanAndroidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FairWidget(
        name: 'hello_world2',
        jsPath: 'file:///android_asset/lib_src_page_sample_page_with_logic2.js',
        path: 'assets/bundle/lib_src_page_hello_world.fair.bin',
      ),
    );
  }
}
