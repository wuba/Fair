import 'package:fair/fair.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'net_demo_pic.js.dart';

@FairPatch()
class PicNetDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FairStateWarpper(_PicNetDemoPageStateful());
  }
}

class _PicNetDemoPageStateful extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: Scaffold(
          appBar: AppBar(
            title: Text('加载网络获取地址的图片'),
          ),
          body: Container(
            child: Column(
              children: [
                Image.network('${_picData.picUrl}', width: double.infinity),
                Text(
                  '${_picData.title}',
                  maxLines: 3,
                  style: TextStyle(color: Colors.blue, fontSize: 19),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: onClick,
          )),
    );
  }
}
