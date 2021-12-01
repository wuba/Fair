---
home: true
heroImage: /logo.png
actionText: Get Started →
actionLink: /guide/
features:
- title: Lightweight Runtime
  details: The core runtime contains only 2.6k lines of Dart. No worry about size.
- title: Seamless Integration
  details: Coding with pure Dart. Integrate package with few configuration.
- title: Expandable Widgets
  details: Custom/3rd Widgets mapping can be easily extended with annotation.
footer: Copyright © 2020 58.com | Powered by The Fair Authors
---
## Quick Start
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
