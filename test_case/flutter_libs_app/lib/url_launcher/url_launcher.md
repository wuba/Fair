# Url Launcher动态化

## 接入方式
### delegate
1、创建获取方法
``` dart
Future<void> _launch() async {
    String url = "http://www.baidu.com";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
 ……
```
2、创建TextField需要绑定的Controller
``` dart

    TextEditingController _editingController = TextEditingController(
        text: "http://www.58.com"
      );

```
3、绑定对应的function和value
``` dart
  @override
    Map<String, PropertyValue> bindValue() {
      var value = super.bindValue();
      value['_textAlign'] = () => _textAlign;
      value['_editingController'] = ()=> ValueNotifier(
        _editingController
      );
      return value;
    }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_launch'] = _launch;
    fun['_launchByInput'] = _launchByInput;
    fun['_email'] = _email;
    fun['_tel'] = _tel;
    fun['_sms'] = _sms;
    return fun;
  }
```

### widget
1、定义字段和方法
```dart 
   @FairWell("_editingController")
   TextEditingController _editingController;
 
   @FairWell("_textAlign")
   TextAlign _textAlign = TextAlign.center;
 
   @FairWell("_launch")
   void _launch(){}
 
   @FairWell("_email")
   void _email(){}
 
   @FairWell("_tel")
   void _tel(){}
 
   @FairWell("_sms")
   void _sms(){}
 
   @FairWell("_launchByInput")
   void _launchByInput(){}
 
   @FairWell("_pop")
   void _pop(){}
```
2、TextField绑定controller
``` dart
    TextField(
      controller: _editingController,
      maxLines: 1,
      minLines: 1,
    )
```
3、onTap时调用方法
``` dart
onTap: _launch,
```

