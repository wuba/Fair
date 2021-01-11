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
  runApp(
    FairApp(
      child: MaterialApp(home: App())
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
