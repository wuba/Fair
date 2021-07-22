import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PicNetDemoFairPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PicNetDemoFairPageState();
}

class PicNetDemoFairPageState extends State<PicNetDemoFairPage> {
  // String path =
  //     'assets/bundle/lib_src_page_plugins_net_pic_net_demo_pic.fair.json';
  String path =
      'assets/bundle/lib_src_page_plugins_net_pic_net_demo_pic2.fair.json';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FairWidget(
          name: 'pic_name',
          path: path,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              path =
                  'assets/bundle/lib_src_page_plugins_net_pic_net_demo_pic.fair.json';
            });
          },
        ),
      ),
    );
  }
}
