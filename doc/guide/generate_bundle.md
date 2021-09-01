# Bundle creation and usage

现在我们已经了解了模板资源的语法和格式，接下来介绍如何从dart源码直接生成bundle文件。

> 目前自动生成能力仅适用于严格的build函数，请确保不包含逻辑运算，生成失败需要手工编写、修正

## 环境检查

首先确保Dart-SDK已经正常配置。通常dart-sdk目录下有如下内容：

```
aven-mac-pro:dart-sdk aven$ ls bin/
dart		dartanalyzer	dartdoc		pub		utils
dart2js		dartaotruntime	dartfmt		resources
dart2native	dartdevc	model		snapshots
```

可以通过以下命令检查：

```shell
which dart2native
```

## bundle生成

在项目的根目录下，执行build_runner触发构建: `flutter pub run build_runner build`

日志较多，可以按需过滤，执行完成后，可以看到生成的bundle文件。

```
aven-mac-pro:example aven$ flutter pub run build_runner build |grep Fair
[Fair] Compile lib/page/zhihu/my_page.dart into bundle...
[Fair] Compile lib/page/hello_world.dart into bundle...
[Fair] Compile lib/page/layout_sugar_page.dart into bundle...
[Fair] New bundle generated => build/fair/lib_page_layout_sugar_page.fair
[Fair] New bundle generated => build/fair/lib_page_zhihu_my_page.fair
[Fair] New bundle generated => build/fair/lib_page_hello_world.fair

```

文件位于`build/fair`目录下，可以取出**.fair**文件，通过网络或者内置在App中使用:

![fair bundle](./assets/fairc-bundle.png)

## bundle使用
通过FairWidget引用bundle资源，更高级的用法请参考demo。
```dart
FairWidget(
  path: 'http://xxx.com/resource.json',
  name: 'demo',
)
```

## 约束

目前bundle能力并不完善，可能会出现错误，如果遇到可以反馈。

无论是bundle编写还是生成，都不能包含逻辑运算，Fair当前只能处理静态的布局渲染。