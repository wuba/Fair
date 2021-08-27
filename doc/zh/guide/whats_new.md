# Fair 2.0 新增内容
Fair 2.0版本新增对逻辑动态化和对Flutter 2.0的版本的支持，其中逻辑动态化支持包括了Fair Compiler工具对Dart2JS的支持、第三方插件（网络、权限、图片选择）自定义扩展接口支持。

## Fair Compiler 完整开源
本次完整开源了Fair Compiler工具，Fair工具包括生成布局DSL的Dart2DSL和生成逻辑JS的Dart2JS部分。
由于compiler 在flutter build命令处理入口，但是在命令运行时下无法Debug，所以拆出了dsrt2dsl和dsrt2js核心转化处理模块，这2个模块都可以进行Debug调试，输入为文件路径。

```
fair
├── dsrt2dsl // dart转dsl的工具部分，生成布局元数据DSL文件
├── dsrt2js // dart转dsl的工具部分，生成逻辑JS文件
└──  compiler  // flutter build 自动动态化产物生成入口
```

## Flutter 2.0.6版本支持
目录名从fair_version变更为flutter_version，内部为动态时创建的Flutter组件。

```
fair
└── flutter_version  // flutter 版本兼容组件
```

## 新增动态逻辑处理能力
Fair 2.0 通过Fair Compiler工具，提取Widget中的逻辑部分并转化成JS文件，送给JSCore处理。Android使用了V8引擎，iOS使用的内置的JSCore。
Fair 2.0 除了JSCore处理逻辑之外，我们还在JS域增加了Fair语法糖和布局方法调用栈处理能力。

## 第三方插件扩展标准化
Fair 2.0 定义了IFairPlugin标准接口，定义了第三方插件接入的标准流程，同时在example中给出了网络、权限和图片选择的Demo。
```
fair
└── fair  // fair引擎模块
    └── example
        └── lib/src/page
                └── plugins 
                    ├── net     // 网络插件
                    ├── permission // 权限插件
                    └── pick-image // 图片选择
```
详见[](./sample_custom_plugin "郭斌勇的主页")