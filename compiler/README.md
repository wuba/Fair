# fair_compiler

A complier which can generate Fair bundle for widget with annotation.

![](http://pic1.58cdn.com.cn/nowater/jltx/n_v26dd88a1afa1c4cc9b186524f96ff3f65.png)
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<p align="center">
  <a href="https://pub.dev/packages/fair"><img src="https://img.shields.io/badge/pub-1.6.0-orange" alt="pub"></a>
  <a href="https://github.com/wuba/fair"><img src="https://img.shields.io/badge/platform-flutter-blue.svg" alt="github"></a>
  <a href="https://fair.58.com/"><img src="https://img.shields.io/badge/doc-fair.58.com-green.svg" alt="doc"></a>
  <a href="https://github.com/wuba/fair/LICENSE"><img src="https://img.shields.io/badge/license-BSD-green.svg" alt="license"></a>
  <a href="https://github.com/wuba/fair/actions"><img src="https://github.com/wuba/fair/workflows/build/badge.svg" alt="build"></a>
  <a href="https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge"><img src="https://badges.gitter.im/flutter_fair/community.svg" alt="Gitter"></a>
</p>

---

Fair is a lightweight package for Flutter, which can be used to update widget tree and state dynamically. This package is still at an early stage.

We create Fair so we can dispatch any pages changes to users as bundle(s), the way similar to React Native. With Flutter Fair integrated, you can publish your pages without waiting for the next release date of your App. Fair provides standard widget and some logic plugins, it can be used as a new dynamic page or as part of existing Flutter page.

![](http://pic1.58cdn.com.cn/nowater/jltx/n_v22cf3e54537a64a9f8bbbf97fb14ff0e4.png)

Fair's UI rendering is lossless and can be restored at the pixel level. Take a look at the effect of escaping some pages of Best Flutter UI Templates:

![](http://pic1.58cdn.com.cn/nowater/jltx/n_v2457753d0105e476dabee461f6fd74bd1.png)

> The project used is from https://github.com/mitesh77/Best-Flutter-UI-Templates </br>
> location：/example/lib/best_flutter_ui

## 🚀 Running
Use Flutter Fair require few steps.

**step1：download fair project source code**

It is recommended to download [fair](https://github.com/wuba/fair) to the local and dependencies on the relative path.

The download method is as follows:

```
git clone https://github.com/wuba/fair.git
```

**step2：Add dependency inside `pubspec.yaml`**

Assuming that the fair project and your own project are in the same folder:

```yaml
# add Fair dependency
dependencies:
  fair: 3.0.0

# add build_runner and compiler dependency
dev_dependencies:
  build_runner: ^2.0.0
  fair_compiler: ^1.6.0
 
# switch "fair_version" according to the local Flutter SDK version
# Flutter SDK 3.0.x(3.0.0、3.0.1、3.0.2、3.0.3、3.0.4、3.0.5) -> flutter_3_0_0
# Flutter SDK 2.10.x(2.10.0、2.10.1、2.10.2、2.10.3) -> flutter_2_10_0
# Flutter SDK 2.8.x(2.8.0、2.8.1) -> flutter_2_8_0
# Flutter SDK 2.5.x(2.5.0、2.5.1、2.5.2、2.5.3) -> flutter_2_5_0
# Flutter SDK 2.0.6 -> flutter_2_0_6
# Flutter SDK 1.22.6 -> flutter_1_22_6
dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_3_0_0
```

**step3：Wrap your app with FairApp Widget**

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

**step4：Import a dynamic widget as FairWidget**

```dart
FairWidget(
  name: 'DynamicWidget',
  path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
  data: {"fairProps": json.encode({})}),
```

## Documentation
For more details, please refer to [https://fair.58.com](https://fair.58.com)