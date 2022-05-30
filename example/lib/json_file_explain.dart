import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/// 本 demo 是用于解释 JSON 文件结构
@FairPatch()
class JsonFileExplain extends StatefulWidget {
  const JsonFileExplain({Key? key}) : super(key: key);

  @override
  _JsonFileExplainState createState() => _JsonFileExplainState();
}

class _JsonFileExplainState extends State<JsonFileExplain> {
  int _counter = 0;

  /// 普通方法（非布局方法）
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// 一个返回 Title 的布局方法
  Widget _buildTitle() {
    return Text('title');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 引用一个布局方法，将被解析成 "%(_buildTitle)"
        title: _buildTitle(),
      ),
      body: Center(
        child: Column(
          /// 引用一个枚举，将被解析成 "#(MainAxisAlignment.center)"
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            /// 引用一个变量，将被解析成 "#($_counter)"
            Text(
              '$_counter',
              style: TextStyle(
                  fontSize: 40, color: Color(0xffeb4237), wordSpacing: 0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// 引用一个非布局方法，将被解析成 "@(_incrementCounter)"
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        /// 引用一个常量，将被解析成 "#(Icons.add)"
        child: const Icon(Icons.add),
      ),
    );
  }
}
