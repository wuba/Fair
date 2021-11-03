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

Fair是为Flutter设计的动态化框架，通过Fair Compiler工具对原生Dart源文件的自动转化，使项目获得动态更新Widget的能力。

Fair is a dynamic framework designed for Flutter, which enables projects to dynamically update Widget through the automatic conversion of native Dart source files through the Fair Compiler tool.

> 在线文档：[https://fair.58.com/](https://fair.58.com/)

![](fair/what-is-fair.png)

Fair的UI渲染是无损的，可以做到像素级别的还原，看一张转义Best Flutter UI Templates部分页面后的效果：

![best-ui-template](best-ui-template.png)

> 使用的工程来自 https://github.com/mitesh77/Best-Flutter-UI-Templates


## 🏛Architecture

![fair architecture](fair.png)

## 🚀 Running

为了方便接入&体验Fair框架，请确认你的Flutter运行环境，可以根据实际情况切换版本。目前支持版本（如遇问题，Issue反馈）：

| Flutter版本              | Dart版本    | CI |
| ------------------------ | ----------- |----------- |
| Flutter 2.5.0           | Dart 2.14.0 | ![v2.5.0](https://github.com/wuba/fair/workflows/build/badge.svg)|
| Flutter 2.0.6           | Dart 2.12.3 | ![v2.0.6](https://github.com/wuba/fair/workflows/build/badge.svg)|
| Flutter 1.22.6           | Dart 2.10.5 | ![v1.22.5](https://github.com/wuba/fair/workflows/build/badge.svg)|
| Flutter 1.22.4           | Dart 2.10.4 | ![v1.22.5](https://github.com/wuba/fair/workflows/1224/badge.svg)|
| Flutter 1.20.4           | Dart 2.9.2  | ![v1.20.4](https://github.com/wuba/fair/workflows/1204/badge.svg)|
| Flutter 1.17.3           | Dart 2.8.4  | ![v1.17.3](https://github.com/wuba/fair/workflows/1173/badge.svg)|
| Flutter 1.12.13+hotfix.9 | Dart 2.7.2  | ![v1.12.13](https://github.com/wuba/fair/workflows/11213/badge.svg) |

```
# Switch to another stable flutter version
#dependency_overrides:
#  fair_version:
#    path: ../fair/flutter_version/flutter_2_5_0

```
> https://flutter.dev/docs/development/tools/sdk/releases?tab=macos

注意：由于部分版本flutter构建脚本存在巨大变化，会导致同一个模板工程无法同时运行在不同版本。

Fair的example位于fair/example目录，同时也附带了一些社区demo并转为fair动态化形式，工程位于samples目录下，克隆后直接build对应仓库即可即可。

```
samples
├── adobe_xd // adobe_xd插件demo, xd插件可以从设计稿直接导出flutter代码
├── best_flutter_ui_templates // 一个UI很漂亮的Flutter模板项目
└── my_app  // 经典的Flutter Hello World
    ├── README.md
    ├── android
    ├── assets
    ├── build
    ├── ios
    ├── lib
    ├── my_app.iml
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── test
    └── web
```

更多接入操作请参考 [https://fair.58.com/](https://fair.58.com/)

* fair ![https://pub.dev/packages/fair](https://img.shields.io/pub/v/fair.svg)
* compiler ![https://pub.dev/packages/fair_compiler](https://img.shields.io/pub/v/fair_compiler.svg)
* annotation ![https://pub.dev/packages/fair_annotation](https://img.shields.io/pub/v/fair_annotation.svg)
* version ![https://pub.dev/packages/fair_version](https://img.shields.io/pub/v/fair_version.svg)

## 📎相关介绍
* [Flutter动态化框架Fair文档上线&开源倒计时](https://juejin.cn/post/6901600898603024391)
* [Flutter动态化框架Fair的设计与思考](https://juejin.cn/post/6896655572910014478)
* [Fair 2.0 逻辑动态化开源了！](https://mp.weixin.qq.com/s/HtrA2DExSeY9VvtDlTch3w)
* [Fair逻辑动态化架构设计与实现](https://mp.weixin.qq.com/s/Xq5BAa6G8vtgP2SePbj-OQ)
* [Fair逻辑动态化通信实现](https://mp.weixin.qq.com/s/8G5rEXc0ZatBGSXrZXc-4A)
* [Fair下发产物-布局DSL生成原理](https://mp.weixin.qq.com/s/oSsSlYPTATZGzYpX7S9o5Q)
* [Fair 逻辑语法糖设计与实现](https://mp.weixin.qq.com/s/dlQ7Uv7u7VI-xSstmJXcwQ)
* [Fair热更新设计与实现](https://mp.weixin.qq.com/s/X3JBDNnqrsejxEwxSQ9-wg)
* [Fair在安居拍房App中的实践](https://mp.weixin.qq.com/s/0J3nJTuoJrWxjy2p0ks0JQ)
* [Flutter 动态化项目评测](https://mp.weixin.qq.com/s/Vc6YJfLgV93PyB8u_dry2A)

## 🕰2020&2021 Roadmap

* 开源准备 2020
	* 项目清理 ✅
	* 对外文档准备 ✅
	* 官网准备 https://fair.58.com ✅
	* Github开源 https://github.com/wuba/fair ✅
  * i18n ⚠️✅
* Bug修复
	* Github issue处理✅
* 维护迭代 2021
	* Framework适配优化✅
	* 局部刷新支持 ✅
	* 状态库支持Provider ✅
	* 独立cli工具
	* 转化优质Demo ✅
  * 动画支持的形式
  * Flutter Favorite Package支持 ✅
  * 其他Top UI Package支持
  * 逻辑组件优化 ✅
  * CI流程✅
  * 社区插件贡献方式

* Fair 2.0
  * 支持逻辑运算 ✅
  * 默认支持网络、权限选择和图片选择插件 ✅
  * 支持第三方插件在逻辑运算中的扩展 ✅
  * 支持布局build方法的子方法拆封 ✅
  * 支持布局和逻辑的混编 ✅
  * 转换工具开源 ✅  

## ⚠️Unsupported Features
由于dart语法解析工作量奇大，会有部分语法和特殊使用方式的限制。
下面是一些，不支持特性&已知问题：
* 链式点语法，如：Colors.black.withOpacity(0.59)，Colors.xxx本身是支持的，但是再次转换透明的则不支持
* 类的继承不支持 
查阅更多不支持内容，请移步至[![Gitter](https://badges.gitter.im/flutter_fair/community.svg)](https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Contributors
刘阳、王海君、林乐洋、卜杰、罗正龙、柯超、单鹏涛、李昊、谢雄亮、赵倩、陈有余、刘超、孙哲

## 🔧Contributing
通过[Issue](https://github.com/wuba/fair/issues)提交问题，贡献代码走Pull Request，管理员将对代码进行审核。

对Fair感兴趣的小伙伴，可以加入交流群。技术咨询、讨论，请移步至[![Gitter](https://badges.gitter.im/flutter_fair/community.svg)](https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

| 微信                         | 美事（内部）                 |
| ---------------------------- | ---------------------------- |
| ![wechat](./weixin.jpeg) | ![meishi](./meishi.jpeg) |

> 微信入群：请先添加58技术小秘书为好友，备注fair，小秘书邀请进群。


## 🧯FAQ
**自查步骤（新手必读）**
1. 核对flutter版本与readme说明，确认该版本已被Fair支持
2. 核查version分支版本于flutter一致，且等同于第一步版本号
2. 如果尚未看过[文档](https://fair.58.com)，请先运行自带的sample，能跑起来再接入app
3. 遇到编译错误，请查看终端日志，过滤fair关键词
4. 使用动态化组件的过程中，不建议格式化生成的Javascript文件，格式化工具可能会修改文件内容，导致执行报错
5. 到github提issue，或gitter。留档/解决，并提供flutter环境信息`flutter doctor --verbose`
---

* 为什么没有bin产物？

bin为可选的flatbuffer产物，fair 2期开源了 fairc和dart2js编译转换工具。

* 执行flutter pub run build_runner build后没有产物？

请根据适配要求，核查flutter，dart版本

* 执行flutter pub run build_runner build后，提示编译错误信息？

根据错误日志，有几种情况：1.原代码中存在逻辑表达式，语法解析不通过，尝试剥离逻辑为module；2.`.dart_tool`文件权限问题，请删除后重试

## LICENSE
Fair项目基于[BSD协议](LICENSE)开源。我们使用的更多依赖库详见pubspec.yaml

> 感谢UXD的**Kaibin**老师提供设计支持

## 支持Fair
点亮**Star**是对Fair团队最大的支持，感谢！
