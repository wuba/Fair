# Package Info动态化

## 接入方式
### delegate
1、创建获取方法
``` dart
  Future<void> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
       _appName = packageInfo.appName ?? '没获取到';
       _packageName = packageInfo.packageName ?? '没获取到';
       _version = packageInfo.version ?? '没获取到';
       _buildNumber = packageInfo.buildNumber ?? '没获取到';
    });
  }
```
2、生命周期initState时调用
``` dart

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

```
3、绑定对应的function和value
``` dart
  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_appName'] = () => _appName;
    value['_packageName'] = () => _packageName;
    value['_version'] = () => _version;
    value['_buildNumber'] = () => _buildNumber;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_getPackageInfo'] = _getPackageInfo;
    return fun;
  }
```

### widget
1、定义字段和方法
```dart 
  @FairWell('_appName')
  String _appName = "";
  @FairWell('_packageName')
  String _packageName = "";
  @FairWell('_version')
  String _version = "";
  @FairWell('_buildNumber')
  String _buildNumber = "";


  @FairWell('_getPackageInfo')
  Future<void> _getPackageInfo() async {

  }
```
2、布局中正常调用
``` dart
    Text(
                    "appName= $_appName",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF333333)
                    ),
                  ),
```
3、onTap时调用方法
``` dart
onTap: _getPackageInfo,
```

