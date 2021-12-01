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
  details: 通过一份Flutter源代码，动态&原生灵活转换，成本无限小。  
footer: Copyright © 2020 58.com | Powered by The Fair Authors
---
# 现在就上车
集成Flutter Fair只需几步。

## 1. 首先在`pubspec.yaml`内添加依赖

我们推荐的依赖方式是，先将 fair 源码下载到本地，然后通过相对路径依赖，下载方式如下：

```
git clone https://github.com/wuba/fair.git
```

假如 fair 源码工程和您的项目工程位于同一个目录下，则可以这样依赖：

```yaml
# add Fair dependency
dependencies:
  fair:
    path: ../fair/fair

# add compiler dependency
dev_dependencies:
  build_runner: ^1.4.0
  fair_compiler:
    path: ../fair/compiler
 
# switch "fair_version" according to the local Flutter SDK version
dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_2_0_6
```

## 2. 启用容器 FairApp

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

## 3. 引用组件 FairWidget

### 3.1 通过Navigator跳转完整动态界面

```dart
  Navigator.pushNamed(context, 'fair_page',
     arguments: {'name': '逻辑动态界面跳转&传值', 'path': 'assets/bundle/lib_src_page_logic-page2page_sample_logic_page2page.fair.json', 'data': {'pageName': '逻辑动态界面跳转&传值'}});
```

### 3.2 原生动态混用（例如原生list中的一个卡片是动态的，详见'原生列表+动态Cell' Demo）
```dart
FairWidget(
  name: item.id,
  path: 'assets/bundle/lib_src_page_list_cells_sample_page_stateful_cell.fair.json',
  data: {"fairProps": json.encode({'louPanDetail': louPanDetail})},
)
```