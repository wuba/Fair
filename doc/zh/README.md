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
footer: Copyright © 2020 58.com | Powered by The Fair Authors
---
## 现在就上车
集成Flutter Fair只需几步。在`pubspec.yaml`内添加依赖
```yaml
dependencies:
  fair: ^0.2.0
```
启用容器FairApp
```dart
void main() {
  runApp(
    FairApp(
      child: MaterialApp(home: App())
    ),
  );
}
```
引用组件FairWidget
```dart
FairWidget(
  type: 'hello_world',
  path: 'assets/bundle/hello_world.json',
)
```