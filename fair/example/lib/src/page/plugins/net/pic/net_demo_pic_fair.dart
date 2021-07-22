import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';

class PicNetDemoFairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FairWidget(
      name: 'pic_name',
      path: 'assets/bundle/lib_src_page_plugins_net_pic_net_demo_pic.fair.json',
    );
  }
}
