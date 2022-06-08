# Device Info动态化

## 接入方式
### delegate
1、创建获取方法
``` dart
Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
      setState(() {
        _deviceInfo = androidInfo.model;
      });
    } else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
      setState(() {
        _deviceInfo = iosInfo.model;
      });
    }
  }
```
2、生命周期initState时调用
``` dart

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

```
3、绑定对应的function和value
``` dart
  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_getDeviceInfo'] = _getDeviceInfo;
    return fun;
  }

   @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_deviceInfo'] = () => _deviceInfo;
    return value;
  }
```

### widget
1、定义字段和方法
```dart 
  @FairWell('_deviceInfo')
  String _deviceInfo = "";

  @FairWell('_getDeviceInfo')
  Future<void> _getDeviceInfo() async {}
```
2、布局中正常调用
``` dart
    Text(
        "$_deviceInfo",
        style: TextStyle(
            fontSize: 16,
            color: Color(0xFF333333)
        ),
      )
```
3、onTap时调用方法
``` dart
onTap: _getDeviceInfo,
```

