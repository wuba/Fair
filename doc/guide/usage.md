# Getting started

> This post is translated by [ME-smile](https://github.com/ME-smile)

## Dependency

Add Fair as a dependency int the *pubspec.yaml* file.

```yaml
# add Fair dependency
dependencies:
  fair: ^0.2.0
# add compiler dependency
dev_dependencies:
  build_runner: ^1.4.0
  fair_compiler:
    path: ../../compiler
```

* fair ![https://pub.dev/packages/fair](https://img.shields.io/pub/v/fair.svg)
* compiler ![https://pub.dev/packages/fair_compiler](https://img.shields.io/pub/v/fair_compiler.svg)
* annotation ![https://pub.dev/packages/fair_annotation](https://img.shields.io/pub/v/fair_annotation.svg)
* flutter_version ![https://pub.dev/packages/fair_version](https://img.shields.io/pub/v/fair_version.svg)

Please check the runtime environment on your computer. Fair is based on Flutter 1.20.4 & 1.22.4 .The latest stable flutter version will continue to be supported in the future. Currently supported versions are listed bellow (If you encounter problems, issue feedback):

| Flutter Version          | Dart Version|
| ------------------------ | ----------- |
| Flutter 2.0.6   | Dart 2.12.3 |
| Flutter 1.22.4/1.22.5    | Dart 2.10.4 |
| Flutter 1.20.4           | Dart 2.9.2  |
| Flutter 1.17.3           | Dart 2.8.4  |
| Flutter 1.12.13+hotfix.9 | Dart 2.7.2  |

> [https://flutter.dev/docs/development/tools/sdk/releases?tab=macos](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos)

To compact with Flutter, you need to get right flutter version. For example, when you checkout the flutter version 1.12.13, fair needs to switch synchronously.

```yaml
# Switch to another stable flutter version
dependency_overrides:
  fair_version:
    git:
      url: https://github.com/wuba/fair.git
      ref: main
      path: fair_version/flutter_1_22_4
```

## Using Fair

Follow these steps:

> 1.Set `FairApp` as top widget

The common way is set *Fair App* as the root node of the App. You can use it as root node of the page view, too.

```dart
void main() {
  runApp(
    FairApp(
      child: MaterialApp(home: App())
    ),
  );
}
```

> 2.add `FairWidget`

A FairWidget represents a dynamic widget

```dart
FairWidget(
  type: "video_card",
  data: {
    "url": 'assets/bundle/video_card.json',
  },
)
```

According to your situation, you can use FairWidget and Flutter widget together or alone:

1. FairWidget can work with other different widgets.
2. In general, FairWidget displays as a full screen page widget.
3. FairWidget can be nested. That is to say it can be partially nested under a common flutter Widget, or it can be nested under another FairWidget.

For detail ,please refer to the example under repo.

