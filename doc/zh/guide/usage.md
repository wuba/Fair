# Flutter Fair接入

## 添加依赖
通过yaml添加依赖配置

推荐将 [fair](https://github.com/wuba/fair) 下载到本地，通过 path 相对路径进行依赖。假设 fair 项目和您自己的项目位于同一个文件夹下面：

```yaml
# 添加 Fair 依赖
dependencies:
  fair:
    path: ../fair/fair
# 添加编译器依赖
dev_dependencies:
  build_runner: ^1.4.0
  fair_compiler:
    path: ../fair/compiler
```

* fair ![https://pub.dev/packages/fair](https://img.shields.io/pub/v/fair.svg)
* compiler ![https://pub.dev/packages/fair_compiler](https://img.shields.io/pub/v/fair_compiler.svg)
* annotation ![https://pub.dev/packages/fair_annotation](https://img.shields.io/pub/v/fair_annotation.svg)
* version ![https://pub.dev/packages/fair_version](https://img.shields.io/pub/v/fair_version.svg)

为了方便接入&体验Fair框架，请确认你的Flutter运行环境，Fair基于Flutter 1.22.4开发,目前已适配至2.0.6, **推荐使用v1.22.4体验**。

后续将继续支持最新稳定版本。目前支持版本（如遇问题，Issue反馈）：

| Flutter版本              | Dart版本    |
| ------------------------ | ----------- |
| Flutter 2.0.6    | Dart 2.12.3 |
| Flutter 1.22.4/1.22.5    | Dart 2.10.4 |
| Flutter 1.20.4           | Dart 2.9.2  |
| Flutter 1.17.3           | Dart 2.8.4  |
| Flutter 1.12.13+hotfix.9 | Dart 2.7.2  |

> [https://flutter.dev/docs/development/tools/sdk/releases?tab=macos](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos)

通过切换fair_version版本进行版本兼容。例如，将本机切换为flutter 1.22.4后，Fair需要同步切换

```yaml
# Switch to another stable flutter version
dependency_overrides:
  fair_version:
    git:
      url: https://github.com/wuba/fair.git
      ref: main
      path: fair_version/flutter_1_22_4
```

## Fair接入

在App中接入Fair步骤如下：

> 1.将FairApp添加为需要动态化部分的顶级节点

常见做法是作为App的根节点，如果不是全局采用也可以作为子页面的根节点

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    _getApp(),
    plugins: {
      'FairNet': FairNet(),
    },
  );
}


```


> 2.添加动态组件

每一个动态组件由一个`FairWidget`表示。

```dart
FairWidget(
  type: "video_card",
  data: {
    "url": 'assets/bundle/video_card.json',
  },
)
```
根据不同场景诉求，FairWidget可以混合和使用
1. 可以作为不同组件混合使用
2. 一般作为一个全屏页面
3. 支持嵌套使用，即可以局部嵌套在普通Widget下，也可以嵌套在另一个FairWidget下

相关示例详情，请查看example代码