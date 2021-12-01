# Flutter Fair接入

## 1. 添加依赖

推荐将 [fair](https://github.com/wuba/fair) 下载到本地，通过 path 相对路径进行依赖。假设 fair 项目和您自己的项目位于同一个文件夹下面：

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

为了方便接入&体验 Fair 框架，请确认你的 Flutter 运行环境，Fair 基于 Flutter 1.22.4 开发，目前已适配至 2.5.0。

后续将继续支持最新稳定版本。目前支持版本（如遇问题，Issue反馈）：

| Flutter版本              | Dart版本    |
| ------------------------ | ----------- |
| Flutter 2.5.0    | Dart 2.14.0 |
| Flutter 2.0.6    | Dart 2.12.3 |
| Flutter 1.22.4/1.22.5    | Dart 2.10.4 |
| Flutter 1.20.4           | Dart 2.9.2  |
| Flutter 1.17.3           | Dart 2.8.4  |
| Flutter 1.12.13+hotfix.9 | Dart 2.7.2  |

> [https://flutter.dev/docs/development/tools/sdk/releases?tab=macos](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos)

通过切换 flutter_version 版本进行版本兼容。例如，将本机切换为 flutter 2.0.6 后，Fair 需要同步切换

```yaml
# switch to another stable flutter version
dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_2_0_6
```

## 2. 使用 Fair

在App中接入Fair步骤如下：

### 2.1 将 FairApp 添加为需要动态化部分的顶级节点

常见做法是作为 App 的根节点，如果不是全局采用也可以作为子页面的根节点

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
  ),
);
```

### 2.2 添加动态组件

每一个动态组件由一个`FairWidget`表示。

```dart
FairWidget(
  name: 'DynamicWidget',
  path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
  data: {"fairProps": json.encode({})}),
```

根据不同场景诉求，FairWidget可以混合和使用
1. 可以作为不同组件混合使用
2. 一般作为一个全屏页面
3. 支持嵌套使用，即可以局部嵌套在普通Widget下，也可以嵌套在另一个FairWidget下

相关示例详情，请查看 example 代码