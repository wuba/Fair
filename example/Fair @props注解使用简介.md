### Fair @props注解使用简介

#### 1.当fairwiget需要接受来自外部的参数用于页面绘制,fairwidget 提供了data参数用于接收来自外部的参数

```dart
FairWidget(
      ///name 页面唯一id,每个FairWidget使用不同的name,此处暂时使用fairPath
      ///当做name
      name: fairPath,
      path: fairPath,

      ///此处data传递需要使用fairProps为key的map,固定写法
      ///fairArguments可以是model的jsonString,建议使用
      ///jsonEncode转换成jsonString
      data: {
        'fairProps': jsonEncode(fairArguments),
      },
    )
```


#### 2.在被@FairPatch()注解标注的需要被转换成fair文件的widget中声明

```dart
class _FairPropsWidgetState extends State<FairPropsWidget> {

  ///接收data参数的变量需要使用FairProps注解标记
  @FairProps()
  var data;
  .......此处省略
```
使用FairProps注解声明需要用来接收的外部参数的成员变量,变量类型使用var


#### 3.在widget中使用接收到的props
```dart
///widget需要用的的变量请使用方法声明再使用
 String fairText(){
    return data["fairText"];
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(fairText(),style: TextStyle(color: Colors.red,fontSize: 20),),
        ),
      ),
    );
  }
```
fairwidget中需要使用变量的,需要声明成方法再去使用,接收到的props data实际会被转换成map类型,通过js绑定,使用者无需关心,需要使用map内的数据,只需声明成方法获取,然后页面widget中使用该方法就能获取到数据并填充.
