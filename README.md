![social preview](social-dark.png)

<p align="center">
  <a href="https://pub.dev/packages/fair"><img src="https://img.shields.io/pub/v/fair.svg" alt="pub"></a>
  <a href="https://github.com/wuba/fair"><img src="https://img.shields.io/badge/platform-flutter-blue.svg" alt="github"></a>
  <a href="https://fair.58.com/"><img src="https://img.shields.io/badge/doc-fair.58.com-green.svg" alt="doc"></a>
  <a href="https://github.com/wuba/fair/LICENSE"><img src="https://img.shields.io/badge/license-BSD-green.svg" alt="license"></a>
  <a href="https://github.com/wuba/fair/actions"><img src="https://github.com/wuba/fair/workflows/build/badge.svg" alt="build"></a>
  <a href="https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge"><img src="https://badges.gitter.im/flutter_fair/community.svg" alt="Gitter"></a>
</p>

[简体中文](README-zh.md)|[English](README.md)

---

Fair is a lightweight package for Flutter, which can be used to update widget tree and state dynamically. This package is still at an early stage.

We create Fair so we can dispatch any pages changes to users as bundle(s), the way similar to React Native. With Flutter Fair integrated, you can publish your pages without waiting for the next release date of your App. Fair provides standard widget and some logic plugins, it can be used as a new dynamic page or as part of existing Flutter page.

![](fair/what-is-fair-en.png)

## Quick Start
Use Flutter Fair require few steps. Add dependency inside `pubspec.yaml`.

Download fair project source code,then dependencies on relative paths,If fair project and your project are in the same directory:

```yaml
dependencies:
  fair:
    path: ../fair/fair

dev_dependencies:
  build_runner: ^1.4.0
  fair_compiler:
    path: ../fair/compiler

dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_2_0_6
```

Wrap your app with FairApp Widget.
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  FairApp.runApplication(
    FairApp(
      child: MyApp(),
    ),
  );
}
```

Import a dynamic widget as FairWidget
```dart
FairWidget(
  type: 'hello_world',
  path: 'assets/bundle/hello_world.json',
)
```

## Documentation
For more details, please refer to [https://fair.58.com](https://fair.58.com)

## Support
The simplest way to show us your support is by giving the project a star.
