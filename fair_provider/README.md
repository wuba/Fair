`fair-provider` 是为了丰富 `fair` 的状态管理能力，以 `provider` 原理进行封装的sdk。使用其可以以类似 `provider` 的用法在 `fair` 页面中进行状态管理。

目前对 `provider` 中部分组件进行了适配支持，可以满足基本场景的使用，核心组件对应关系如下：
- ChangeNotifierProvider =>  [FairChangeNotifierProvider]()
- Consumer =>  [FairConsumer]()
- Selector =>  [FairSelector]()
- ChangeNotifier =>  [FairChangeNotifier]()

## 快速接入
pub添加依赖
```yaml
dependencies:
  fair_provider: ^0.0.1
```

初始化FairApp时传入FairProviderAdapter
```dart
///入口函数
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    FairApp(
      child: const MyApp(),
    ),
    adapters: [FairProviderAdapter()],
  );
}
```

## 基本使用
以计数器举例
首先声明状态管理类，继承 `FairChangeNotifier`
```dart
class CounterModel extends FairChangeNotifier {
  int count = 0;
}
```
创建Provider，将初始化数据以json的形式传入
```dart
  var initialJson = '''
{
    "count":22
}
      ''';

  @override
  Widget build(BuildContext context) {
    return FairChangeNotifierProvider<CounterModel>(
      initialJson: initialJson,
      child: ...
    );
  }
```
使用 `FairConsumer`/`FairSelector` 配合语法糖来观察状态变更
```dart
  FairConsumer<CounterModel>(
    builder: SugarProvider.consumerBuilder(
        (context, value, child) =>
            Text(SugarProvider.readAsString(value, 'count'))),
  )
```
编写事件处理函数，更新状态
注意read函数的泛型即是状态管理类的类型，参数需要手动输入该类的字符串
```dart
  void _incrementCounter(FairContext context) {
    var counterModel = context.read<CounterModel>("CounterModel");
    counterModel.count++;
    counterModel.notify();
  }
```
由于fair中的逻辑函数会经 `dart2js` 编译器转换为js，所以是不支持 `BuildContext` 上下文的，这里需要使用经过特殊处理的 `FairContext`，`FairContext` 的构造需要 `FairContextBuilder` 配合语法糖 `SugarProvider.widgetBuilder` 来获取
```dart
FairContextBuilder(
    builder: SugarProvider.widgetBuilder((context) => FloatingActionButton(
                    onPressed: () {
                      _incrementCounter(context);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  )),
),
```

## 进阶使用
由于 `fair` 的布局动态化特性，在构建布局时不支持随意编写取值代码，这里需要借助 [SugarProvider]() 中的一系列语法糖来完成

这里以example中的基本示例代码举例
```dart
class ExampleModel extends FairChangeNotifier {
  String? stringField;
  int intField = 1;
  double? doubleField;
  bool boolField = false;
  List? listField;
  ExampleInnerModel? innerModel;
}

class ExampleInnerModel {
  bool? innerBoolField;
}
```
语法糖提供了基本类型和数组的取值api，具体使用细节可以参考example中的 [基本使用示例]()
```dart
///一个读取字符串的例子
FairConsumer<ExampleModel>(
    builder: SugarProvider.consumerBuilder(
        (context, value, child) => Text(SugarProvider.readString(value, 'stringField'))),
),
```
- **readString** 使用key从model中读取String类型的值
- **readAsString** 使用key从model中读取并强转为String类型的值
- **readInt** 使用key从model中读取Int类型的值
- **readDouble** 使用key从model中读取Double类型的值
- **readBool** 使用key从model中读取布尔型的值
- **readList** 使用key从model中读取数组类型的值
- **readDynamic** 使用key从model中读取任意类型的值

还支持表达式取值，使用规则如 `a.b.c`
```dart
FairSelector<ExampleModel, String>(
    builder: SugarProvider.selectorBuilder((context, value, child) => Text(value)),
    selector: SugarProvider.selector((context, value) =>SugarProvider.evaluationAsString(value, 'innerModel.innerBoolField'))
)
```
- **evaluationToString** 使用表达式从model中读取String类型的值
- **evaluationAsString** 使用表达式从model中读取并强转为String类型的值
- **evaluationToInt** 使用表达式从model中读取Int类型的值
- **evaluationToDouble** 使用表达式从model中读取Double类型的值
- **evaluationToBool** 使用表达式从model中读取布尔型的值
- **evaluationToList** 使用表达式从model中读取数组类型的值
- **evaluationToDynamic** 使用表达式从model中读取任意类型的值
