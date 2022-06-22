# flutter_all_widgets

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 组件兼容测试
** widget ** | ** 描述 ** | ** 是否解决** | **备注**
:-: |  :-: |  :-: |  :-:
CheckBox |onChanged属性，写法 (value) =>checked = value)； (value) {checked = value;})写法会报"type String is not a subtype of type '(bool?) =>void)?'"| 否||
        | 不识别 MaterialStateProperty | 否 |
        | value属性，值必须true或false，如果是变量或是方法会报 type 'String' is not a subtype of type 'bool?'| 否 |


