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
Use Flutter Fair require few steps. Add dependency inside `pubspec.yaml`.
```yaml
dependencies:
  fair: ^0.2.0
```

Wrap your app with FairApp Widget.
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

Import a dynamic widget as FairWidget
```dart
FairWidget(
  name: 'DynamicWidget',
  path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
  data: {"fairProps": json.encode({})}),
```
