import 'package:fair/fair.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'net_demo_pic2.js.dart';

/*
 * 显示一个大暑的页面
 */
@FairPatch()
class PicDemoPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PicNetDemoPageStateful();
  }
}

class _PicNetDemoPageStateful extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: Scaffold(
        appBar: AppBar(
          title: Text('插件'),
        ),
        body: Container(
          child: Column(
            children: [
              Image.network(
                '$_picUrl',
                width: 1000,
                height: 300,
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
              ),
              Expanded(
                child: Text(
                  '$description',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.autorenew),
        //   onPressed: onClick,
        // )
      ),
    );
  }

// void onClick() {}
}
