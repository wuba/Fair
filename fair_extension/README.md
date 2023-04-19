## 背景
关于Fair 的动态化能力支持，涉及到如下几个方面：
- 平台相关能力，如打电话、定位、权限申请、相机等
- 业务逻辑相关，路由、埋点等
  需要提前内置逻辑，否则开发阶段需要使用这些能力时，需要发版内置，丧失了Fair 动态化能力的优势。

为了避免出现上述问题，我们希望在Fair 接入阶段，就内置常用的业务逻辑。并且我们把通用的业务逻辑以扩展包的形式提供给开发者。开发者在Fair 接入阶段，通过依赖扩展包，经过简单的配置，就可以实现常用业务逻辑的支持。

## 目前支持
#### Log
示例：

```
FairLog.log('点击展示 Count Value:: $_count');
```

#### Toast
示例：

```
FairToast.show(
      msg: '这是一个 `Short Toast`',
      toastLength: Toast.LENGTH_SHORT,
    );
```

#### 网络请求
示例：

```
FairNet.requestData(
        method: FairNet.GET,
        url:
            'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/6f8e5d9e196cbaa4a46041928770b187_grid_data.json',
        data: {'page': _page},
        success: (resp) {
          if (resp == null) {
            return;
          }
          var data = resp['data'];
          data.forEach((item) {
            var dataItem = ItemData();
            dataItem.picUrl = item['imagePath'];
            _listData.add(dataItem);
          });
          setState(() {});
        });
```

#### 权限申请
示例：

```
FairPermission.requestPermission(
        type: FairPermission.permissionPhoto,
        granted: () {
          isGranted = true;
          takePhoto();
        },
        restricted: () {
          isGranted = false;
          takePhoto();
        });
```

#### 图片选择/调用相机
示例：

```
FairImagePicker.getImage(
        type: FairImagePicker.album,
        success: (resp) {
          picUrl = resp;
          setState(() {});
        },
        failure: () {
          //用户获取图片失败
        });
```

#### url_launcher(电话、短信、邮件、web等)
示例：

```
// 打电话
FairUrlLauncher.makePhoneCall(_phone);
// 打开web页
FairUrlLauncher.launchInBrowser(_url);
```

#### 页面跳转
示例：

```
FairNavigator.pushNamed(
        routeName: 'flutter_page_for_fair_navigator',
        arguments: {
          'page_name':'使用FairNavigator传参到Flutter页面',
          'button_list': [
            'one',
            'two',
            'three',
            'four',
            'five',
          ],
        });
```

#### 持续更新中...

## 接入说明
#### 添加fair_extension 依赖

```
fair_extension: 1.0.0
```

#### fair_extension 初始化
fair 初始化中，设置plugins 及 jsPlugins。

```
FairApp.runApplication(
      FairApp(
        child: const MyApp(),
      ),
      plugins: FairExtension.plugins,
      jsPlugins: FairExtension.jsPlugins);
```

#### fair_extension 使用
详见[example](./example)  
