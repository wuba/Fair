# fair_gallery

[掘金文章地址](https://juejin.cn/post/7228967938473394213)

Fair 使用例子

## 映射自定义

* 执行 `bin/binding/app.dart` 生成项目中代码对应的 组件，api 和 回调映射，项目中有新增文件需要生成的时候执行。
* 执行 `bin/binding/flutter.dart` 生成 当前使用的 Flutter 源码中对应的 组件，api 和 回调映射，只用生成一次。
* 执行 `bin/binging/packages.dart` 生成项目中引用的三方库中对应的 组件，api 和 回调映射，有新的三方库引入的时候执行。
  
`bin/binding/binding.dart` 中是给 `bin/binding/app.dart` 和 `bin/binging/packages.dart` 使用，它的作用类似于

`FairBinding` 注解的用处

## 自动生成与 js 交互的插件

在 `lib/src/plugin` 中增加新的 `plugin`, 比如

``` dart
import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';

mixin DebugPlugin implements FairCommonPluginMixin {
  Future<dynamic> jsPrint(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          if (kDebugMode) {
            debugPrint('来自js的参数:$requestMap');
          }
          return null;
        },
      );
}
```

运行 `bin/fair_common_plugin.dart`, 将自动生成 `fair_common_plugin.js` 和 `fair_common_plugin.dart`



## 一些脚本

### 生成 Dart 基础类型的语法糖

执行 `bin/dart_core.dart` 生成基础类型的语法糖。

![截屏2023-04-12 18.22.31.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9895ea484c084e619285233e0eec2f92~tplv-k3u1fbpfcp-watermark.image?)


### 将扩展方法转换成语法糖

用于旧项目里面的一些扩展方法，将它们转换成语法糖使用。执行 `bin/extension.dart` 


```dart
import 'package:fair_gallery/src/extension/string.dart';

/// StringExtension Sugar
class SugarStringExtension {
  SugarStringExtension._();

  static String test(
    String input,
  ) =>
      input.test();
}

```

### build.sh

生成 Fair 产物，并且复制到 `assets/fair` 下面


### new_page.sh

新增页面，自动生成路由，资源文件的映射
