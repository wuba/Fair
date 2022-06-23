### Fair plugin使用简介
#### 1.plugin介绍
plugin是为了扩展一些公共的功能,为了我们使用fair可以使用一些fair无法实现的功能,通过js层面去内置到app中去实现更多丰富的功能

#### 2.plugin接入文件拷贝
1.添加fair_basic_config.json至assets目录下

```dart
//添加需要交互的plugin js文件路径
{
  "plugin": {
    "fair_basic_plugin": "assets/plugin/fair_basic_plugins.js"
  }
}
```

2.在assets目录下新建plugin文件夹,添加fair_basic_plugins.js文件(具体文件见fair example)

3.在pubspec.yaml文件中声明需要使用的文件路径

```dart
assets:
    - assets/
    - assets/plugin/
```


#### 3.注册plugin

```dart
FairApp.runApplication(
    FairApp(
      child: MyApp(),
    ),
    ///需要在此注册需要全局使用的plugin,key名可以随意不做要求
    plugins: {
      "FairBasicPlugin": FairBasicPlugin(),
    },
  );
```

#### 4.plugin的使用
以下使用打电话举例,plugin的类名需要与js中的变量名保持一致,
重写getRegisterMethods注册需要使用到的方法

```dart
///此处类名需要与js中变量名保持一致
class FairBasicPlugin extends IFairPlugin {

  static final FairBasicPlugin _fairXPlugin = FairBasicPlugin._internal();

  FairBasicPlugin._internal();

  factory FairBasicPlugin() {
    return _fairXPlugin;
  }

  Future<bool> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    return await launchUrl(launchUri);
  }

  Future<dynamic> call(map) async {
    print('FairXPlugin pluginRequest');

    if (map == null) {
      return;
    }
    var req;
    bool isDart;
    if (map is Map) {
      isDart = true;
      req = map;
    } else {
      isDart = false;
      req = jsonDecode(map);
    }

    var args = req['args'];
    var pageName = req['pageName'];
    var id = req['id'];

    var responseCallback = args['response'];
    var type = args['type'];
    switch(type) {
      case 'Call':
        var phoneNumber = args['phoneNumber'];
        var result = await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber));
        if (result) {
          var value = await _makePhoneCall(phoneNumber);
          if (isDart) {
            responseCallback?.call(value);
          } else {
            var resp = {
              'pageName': pageName,
              'id': id,
              'response': value,
            };
            return Future.value(jsonEncode(resp));
          }
        } else {
          throw 'Could not call $phoneNumber';
        }
        break;
    }

    return Future.value();
  }


  ///注册需要被识别的方法名
  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('call', () => call);
    return functions;
  }

}
```

#### 5.fairwidget中使用plugin
以下为固定写法,在fairwidget声明一个方法,在方法中调用plugin中注册的方法,运行时fair js会自动识别绑定,
response为js中写死的回调方法,特殊实现可以修改plugin js文件,一般情况无需修改.

```dart
callPhone(){
    FairBasicPlugin().call({
      'pageName': '#FairKey#',
      'args': {
        'type': 'Call',
        'phoneNumber': '15800342502',
        'response': (data) {
          print('response = $data');
        }
      }
    });
  }
```

