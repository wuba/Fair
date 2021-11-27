# Getting started

> This post is translated by [ME-smile](https://github.com/ME-smile)

## 1. Dependency

It is recommended to download [fair](https://github.com/wuba/fair) to the local and dependencies on the relative path. 

The download method is as follows:

```
git clone https://github.com/wuba/fair.git
```

Assuming that the fair project and your own project are in the same folder:

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

Please check the runtime environment on your computer. Fair is based on Flutter 1.20.4 & 1.22.4 .The latest stable flutter version will continue to be supported in the future. Currently supported versions are listed bellow (If you encounter problems, issue feedback):

| Flutter Version          | Dart Version|
| ------------------------ | ----------- |
| Flutter 2.5.0    | Dart 2.14.0 |
| Flutter 2.0.6   | Dart 2.12.3 |
| Flutter 1.22.4/1.22.5    | Dart 2.10.4 |
| Flutter 1.20.4           | Dart 2.9.2  |
| Flutter 1.17.3           | Dart 2.8.4  |
| Flutter 1.12.13+hotfix.9 | Dart 2.7.2  |

> [https://flutter.dev/docs/development/tools/sdk/releases?tab=macos](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos)

To compact with Flutter, you need to get right flutter version. For example, when you checkout the flutter version 2.0.6, fair needs to switch synchronously.

```yaml
# switch to another stable flutter version
dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_2_0_6
```

## 2. Using Fair

Follow these steps:

### 2.1 Set `FairApp` as top widget

The common way is set `FairApp` as the root node of the App. You can use it as root node of the page view, too.

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

### 2.2 add `FairWidget`

A FairWidget represents a dynamic widget

```dart
FairWidget(
  name: 'DynamicWidget',
  path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
  data: {"fairProps": json.encode({})}),
```

According to your situation, you can use FairWidget and Flutter widget together or alone:

1. FairWidget can work with other different widgets.
2. In general, FairWidget displays as a full screen page widget.
3. FairWidget can be nested. That is to say it can be partially nested under a common flutter Widget, or it can be nested under another FairWidget.

For detail ,please refer to the example under repo.

