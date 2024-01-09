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

## 简单使用
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
使用 `FairConsumer`/`FairSelector` 配合语法糖来观察状态变更，注意由于 `fair` DSL布局的特性，匿名函数是不支持的（后续计划支持优化），所以其中的builder函数还需要语法糖来包装下。最后从自定义的 `FairChangeNotifier` 状态管理对象中取值同样也需要借助语法糖来完成，目前已经提供了大量的取值语法糖，可以满足大多数场景的使用，详细说明可参考进阶使用部分。
```dart
  FairConsumer<CounterModel>(
    builder: SugarProvider.consumerBuilder(
        (context, value, child) =>
            Text(SugarProvider.readAsString(value, 'count'))),
  )
```
```dart
  FairSelector<CounterModel, int>(
    builder: SugarProvider.selectorBuilder(
        (context, value, child) =>
            Text(SugarProvider.anyToString(value))),
    selector: SugarProvider.selector((context, value) =>
        SugarProvider.readInt(value, 'count'))),
```
编写事件处理函数，更新状态
注意read函数的泛型即是状态管理类的类型，参数需要手动输入该类的字符串
```dart
  void _incrementCounter(FairContext context) {
    //通过FairContext获取状态对象
    var counterModel = context.read<CounterModel>("CounterModel");
    //修改对象中的value
    counterModel.count++;
    //调用notify通知观察者
    counterModel.notify();
  }
```
这里需要使用经过特殊处理的 `FairContext`，`FairContext` 的构造需要 `FairContextBuilder` 配合语法糖 `SugarProvider.widgetBuilder` 来获取
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

## 使用说明

### 1. FairChangeNotifier的使用限制

注意 `FairChangeNotifier` 的定义有一些限制，这里以 [example]() 中的ExampleModel举例

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

1. 支持的类型为基本类型和数组
   - int
   - double
   - String
   - bool
   - List
2. 目前只支持基本类型或者简单的嵌套对象（内部也是基本类型），不支持自定义函数（Function）
3. 当需要通知状态更新时需要手动调用`notify`/`notifyListeners`
4. 暂时不支持定义在`bean`结尾的包中

### 2. 在布局中取值需使用语法糖

由于 `fair` 的布局动态化特性，在构建布局时不支持随意编写取值代码，这里需要借助 [SugarProvider]() 中的一系列语法糖来完成

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

还支持表达式取值，使用规则如 `a.b.c`，以上面的ExampleModel为例，如果想读取成员 `innerModel` 中的 `innerBoolField` 字段，使用表达式取值可以这么写
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

## 更多示例请见 [example]()