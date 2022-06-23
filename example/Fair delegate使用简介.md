### Fair delegate使用简介

#### 1.fair中一些widget参数我们无法直接识别成json,需要使用代理方法内置,fair会调用内置方法实现功能
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fair delegate的使用"),
      ),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 10,
      ),
    );
  }
  
  ///fair暂时还不直接识别itemBuilder使用逻辑语句
  ///必须声明成方法,fair内部通过js保存方法,
  ///js无法使用识别dart的context所以js不能识别的方法
  ///建议使用fair delegate去处理
  Widget _itemBuilder(context, index) {
    ///使用delegate后此处返回值无效,可随意返回,真实执行的是fair delegate
    ///中的_itemBuilder方法
    return Container();
  }
```
listview中fair无法直接识别itemBuilder方法,需要我们内置delegate去实现, itemBuilder需要被声明成方法fair才能识别

#### 2.注册delegate
```dart
FairApp.runApplication(
    FairApp(
      child: MyApp(),
      delegate: {
        ///此处delegate注册的key名必须与fairwidget页面name的名字一致,
        ///TestFairDelegate只作用于相同名字的fairwidget
        'assets/fair/lib_fair_widget_fair_delegate_widget.fair.json': (ctx, _) => TestFairDelegate(),
      },
    ),
  );
```
delegate注册时map中key名必须和fairwidget中的name相同,保证只作用于此name下的fairwidget中,限定delete作用域.

#### 2.使用delegate
```dart
///delegate需要继承FairDelegate
///并且在fairApp中注册这个Delegate
class TestFairDelegate extends FairDelegate {
  @override
  Map<String, Function> bindFunction() {
    var bindFunction = super.bindFunction();
    bindFunction.addAll({
      ///此处添加fair widget中声明的_itemBuilder
      ///key必须与声明的方法名一致
      '_itemBuilder': _itemBuilder
    });
    return bindFunction;
  }

  ///此处是正在执行的_itemBuilder方法
  Widget _itemBuilder(context, index) {
    ///如果再delegate中想获取fairwidget中的变量或者调用某个方法
    ///funcName 是fairwidget中的方法名
    ///parameters 方法参数数组
    var invokeMethodSync = runtime?.invokeMethodSync(pageName, 'getData', null);
    var json = jsonDecode(invokeMethodSync!);
    var json2 = json['result']['result'];

    return Container(
      height: 60,
      child: Center(child: Text(json2[index]),),
      color: randomColor(),
    );
  }
}
```
继承FairDelegate,重写bindFunction方法添加需要被识别的方法名和对应的方法实现

#### 4.在delegate中获取页面参数
```dart
///此处是正在执行的_itemBuilder方法
  Widget _itemBuilder(context, index) {
    ///如果再delegate中想获取fairwidget中的变量或者调用某个方法
    ///funcName 是fairwidget中的方法名
    ///parameters 方法参数数组
    var invokeMethodSync = runtime?.invokeMethodSync(pageName, 'getData', null);
    var json = jsonDecode(invokeMethodSync!);
    var json2 = json['result']['result'];

    return Container(
      height: 60,
      child: Center(child: Text(json2[index]),),
      color: randomColor(),
    );
  }
```
通过内置的runtime方法调用js方法获取页面中的方法获取参数,pageName可以控制从具体哪个fairwidget中去获取数据,调用方法,获取到的结果是个string类型,具体需要我们自己去解析,通过转行成map,然后通过json['result']['result']获取我们真正需要的参数
