import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'net/pic/net_demo_pic_fair.dart';

class SamplePluginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SamplePluginState();
}

class SamplePluginState extends State<SamplePluginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            getItem('网络功能', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PicNetDemoFairPage()));
            }),
            getItem('拍照功能', () {}),
          ],
        ),
      ),
    );
  }

  Widget getItem(String text, callBack) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
