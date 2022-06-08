import 'package:fair/fair.dart';
import 'package:fair_list_demo/list_proxy.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FairApp(
    child: MyApp(),
    delegate:  {
      'listDemo': (ctx, _) => ListDelegate(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white, //主题颜色
        highlightColor: Colors.white, //高亮颜色
        splashColor: Colors.white, //洒落，溅射颜色
      ),
      // home: JRListWidget(),
      home: FairWidget(
        path: 'assets/bundle/lib_JRList.fair.json',
        name: 'listDemo',
        data: {
          'data.content': '测试',
        },
      )
    );
  }
}
