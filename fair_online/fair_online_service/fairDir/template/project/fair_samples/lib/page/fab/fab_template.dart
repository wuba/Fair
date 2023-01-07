import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class FabTemplate extends StatefulWidget {
  const FabTemplate({Key? key}) : super(key: key);

  @override
  State<FabTemplate> createState() => _FabTemplateState();
}

class _FabTemplateState extends State<FabTemplate> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              // 暂不支持 style: Theme.of(context).textTheme.headline4,
              // 可替换成:
              style: TextStyle(
                  fontSize: 40, color: Color(0xffeb4237), wordSpacing: 0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        ///设置悬浮按钮的背景
        backgroundColor: Colors.blue,

        ///获取焦点时显示的颜色
        focusColor: Colors.blueAccent,

        ///鼠标悬浮在按钮上时显示的颜色
        hoverColor: Colors.lightBlue,

        ///水波纹颜色
        splashColor: Colors.lightBlueAccent,

        ///配制阴影高度 未点击时
        elevation: 0.0,

        ///配制阴影高度 点击时
        highlightElevation: 20.0,
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
