---
home: true
heroImage: /logo.png
actionText: 快速上手 →
actionLink: /guide/
features:
- title: 小家雀
  details: 核心运行时仅2.6K行代码，身型轻巧，体积没烦恼。
- title: 低侵入
  details: 纯Dart开发，左手Flutter右手Fair，同一片语义下，配上就可以起飞。
- title: 易扩展
  details: 插拔式的组件，一个注解搞定业务组件和社区UI库，扩展你的无限想象。
- title: 更灵活
  details: 通过一份Flutter源代码转换，可以更灵活的在原生和动态之间切换。  
footer: Copyright © 2020 58.com | Powered by The Fair Authors
---
## 现在就上车
集成Flutter Fair只需几步。在`pubspec.yaml`内添加依赖
```yaml
dependencies:
  fair: ^0.2.0
```
启用容器FairApp
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    _getApp(),
    plugins: {
    },
  );
}

dynamic _getApp() => FairApp(
  modules: {
  },
  delegate: {
  },
  child: MaterialApp(
    home: FairWidget(
        name: 'DynamicWidget',
        path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
        data: {"fairProps": json.encode({})}),
    routes: {
       'fair_page': (context) => FairWidget(
              name: _getParams(context, 'name'),
              path: _getParams(context, 'path'),
              data: {
                'fairProps': jsonEncode(
                        _getData(context, _getParams(context, 'name')))
              }),
    },
  ),
);
```

引用组件FairWidget

1、通过Navigator跳转完整动态界面

```dart
  Navigator.pushNamed(context, 'fair_page',
     arguments: {'name': '逻辑动态界面跳转&传值', 'path': 'assets/bundle/lib_src_page_logic-page2page_sample_logic_page2page.fair.json', 'data': {'pageName': '逻辑动态界面跳转&传值'}});
```

2、原生动态混用（例如原生list中的一个卡片是动态的，详见'原生列表+动态Cell' Demo）
```dart
FairWidget(
  name: item.id,
  path: 'assets/bundle/lib_src_page_list_cells_sample_page_stateful_cell.fair.json',
  data: {"fairProps": json.encode({'louPanDetail': louPanDetail})},
)
```