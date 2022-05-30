import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/// 本 demo 演示 counting 的改造
void main() {
  // runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    _getApp(),
    plugins: {},
  );
}

dynamic _getApp() => FairApp(
  modules: {},
  delegate: {},
  child: MyApp(),
);

/// 获取路由传递的参数
dynamic _getParams(BuildContext context, String key) =>
    (ModalRoute.of(context)?.settings.arguments is Map) ? (ModalRoute.of(context)?.settings.arguments as Map)[key] : null;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'fair_page_two': (context) => FairWidget(
              path: _getParams(context, 'path'),
              data: {'fairProps': jsonEncode(_getParams(context, 'data'))}),
        },
        // home: MyHomePage(title: 'Flutter Demo Home Page'),

        /// FairWidget 是用来加载 bundle 资源的容器
        ///
        /// path 参数：需要加载的 bundle 资源文件路径
        /// data 参数：需要传递给动态页面的参数
        home: FairWidget(
            /// path 可以是 assets 目录下的 bundle 资源，也可以是手机存储
            /// 里的 bundle 资源，如果是手机存储里的 bundle 资源需要使用绝对路径
            path: 'assets/bundle/lib_page2page_page_one.fair.json',
          ));
  }
}

@FairPatch()
class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);

  // final String title;

  MyHomePage({Key? key, this.fairProps}) : super(key: key);

  // 通常习惯上，我们将变量名定义为 fairProps
  dynamic fairProps;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /// 定义与 JS 侧交互的参数，只支持 Map 类型的数据
  ///
  /// 需要用 @FairProps() 注解标记
  /// 变量名可以自定义，习惯上命名为 fairProps
  @FairProps()
  var fairProps;

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    /// 需要将 widget.fairProps 赋值给 fairProps
    fairProps = widget.fairProps;
  }

  String getTitle() {
    return fairProps['title'];
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
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
              style: TextStyle(fontSize: 40, color: Color(0xffeb4237), wordSpacing: 0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}