import 'dart:math';

import 'package:example/fair_widget/delegate/test_fair_delegate.dart';
import 'package:example/fair_widget/plugin/fair_basic_plugin.dart';
import 'package:example/home_page.dart';
import 'package:fair/fair.dart';
import 'package:fair_extension/fair_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/module.fair.dart' as g;

@FairBinding(packages: [
  'package:example/fair_widget/fairbinding/fair_binding_widget.dart',
  'package:flutter_staggered_grid_view/src/widgets/staggered_grid.dart',
  'package:flutter_staggered_grid_view/src/widgets/masonry_grid_view.dart'
])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  FairApp.runApplication(
    FairApp(
      child: MyApp(),
      delegate: {
        ///此处delegate注册的key名必须与fairwidget页面name的名字一致,
        ///TestFairDelegate只作用于相同名字的fairwidget
        'assets/fair/lib_fair_widget_fair_delegate_widget.fair.json':
            (ctx, _) => TestFairDelegate(),
      },
      generated: g.FairAppModule(),
    ),

    ///需要在此注册需要全局使用的plugin,key名可以随意不做要求
      plugins: FairExtension.plugins
      ..addAll({'FairBasicPlugin': FairBasicPlugin()}),
      jsPlugins: FairExtension.jsPlugins
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        navigatorKey: FairExtension.fairNavigatorKey);
  }
}

@FairPatch()
class MyHomePage extends StatefulWidget {
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
              style: TextStyle(
                  fontSize: 40, color: Color(0xffeb4237), wordSpacing: 0),
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

Color randomColor() {
  return Color.fromARGB(
      255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
}
