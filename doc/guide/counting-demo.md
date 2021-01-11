# Counting计数器
学习很多语言的时候都有hello world，在Flutter里面他的Hello World是个counting计数器。下面我们把这个计数器转换为Flutter Fair。

相对于前面的写一个红色小块，计数器demo引入了状态State的变更，为了支持状态/局部刷新，需要配套引入state proxy代理对象。

counting工程是模板工程，只需要利用flutter create就可以创建。不同版本可能会略有差异，但是差不太多。核心内容如下
* 一个文本标签，展示计数值
* 一个按钮，更新计数


## 预览效果
|   Flutter   |    Fair  |
| ---- | ---- |
| ![counting old](./assets/counting-old.png)     |  ![counting new](./assets/counting-new.png)    |

## Dart源码
参考源码：
* main.dart

```dart
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

## Fair改造
为了生存代码，我们将main.dart拆分独立文件；
* main.dart runApp入口
* app.dart 从main剥离出app部分
* proxy.dart 新增

### main.dart

替换MyHomePage的引用，改为对FairWidget的引用
```dart {2,6,18-22}
import 'package:demo/proxy.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FairApp(child: MyApp(), profile: true));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FairWidget(
        name: 'counting',
        path: 'assets/bundle/lib_app.fair.bin',
        data: {'widget.title': 'Flutter Demo Home Page'},
        stateProxy: CountingStateProxy(),
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

### app.dart
改造后的app既可以直接运行，也可以作为基础生成fair产物。
```dart {1,13,15,18,25}
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

@FairPatch()
class _MyHomePageState extends State<MyHomePage> {
  @FairWell('_counter')
  int _counter = 0;

  @FairWell('_incrementCounter')
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @FairWell('themeStyle')
  TextStyle themeStyle() {
    return Theme.of(context).textTheme.headline4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: themeStyle(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

### proxy.dart
代理对象，负责状态绑定
```dart
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class CountingStateProxy extends FairStateProxy {
  ValueNotifier<int> _counter;

  void _incrementCounter() {
    _counter.value++;
  }

  @override
  Map<String, FairBlocBuilder> property() {
    var props = super.property();
    _counter ??= ValueNotifier(0);
    props['_counter'] = () => _counter;
    props['themeStyle'] = () => Theme.of(context).textTheme.headline4;
    return props;
  }

  @override
  Map<String, dynamic> func() {
    var func = super.func();
    func['_incrementCounter'] = _incrementCounter;
    return func;
  }
}
```
