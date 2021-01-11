![social preview](social-dark.png)

<p align="center">
  <a href="https://pub.dev/packages/fair"><img src="https://img.shields.io/pub/v/fair.svg" alt="pub"></a>
  <a href="https://github.com/wuba/fair"><img src="https://img.shields.io/badge/flutter-Android%7CiOS%7CWeb-blue.svg" alt="github"></a>
  <a href="https://fair.58.com/"><img src="https://img.shields.io/badge/doc-fair.58.com-green.svg" alt="doc"></a>
  <a href="https://github.com/wuba/fair/LICENSE"><img src="https://img.shields.io/badge/license-BSD-green.svg" alt="license"></a>
  <a href="https://github.com/wuba/fair/actions"><img src="https://github.com/wuba/fair/workflows/build/badge.svg" alt="build"></a>
</p>

[简体中文](README.md)|[English](README-en.md)

---

# WIP

Flutter Fair is a new package used to update widget tree dynamically.

> document: [https://fair.58.com/](https://fair.58.com/)

![](fair/what-is-fair-en.png)

Fair的UI渲染是无损的，可以做到像素级别的还原，看一张转义Best Flutter UI Templates部分页面后的效果：

![best-ui-template](best-ui-template.png)

> This template project is from: https://github.com/mitesh77/Best-Flutter-UI-Templates

## 🏛Architecture

![fair architecture](fair.png)

## 🚀 Running

Please check the runtime environment on your computer. Fair is based on Flutter 1.20.4 & 1.22.4 .The latest stable flutter version will continue to be supported in the future. Currently supported versions are listed bellow (If you encounter problems, issue feedback):

| Flutter Version          | Dart Version|
| ------------------------ | ----------- |
| Flutter 1.22.4/1.22.5    | Dart 2.10.4 |
| Flutter 1.20.4           | Dart 2.9.2  |
| Flutter 1.17.3           | Dart 2.8.4  |
| Flutter 1.12.13+hotfix.9 | Dart 2.7.2  |

> https://flutter.dev/docs/development/tools/sdk/releases?tab=macos

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

## 📎相关介绍
* [Flutter动态化框架Fair文档上线&开源倒计时](https://juejin.cn/post/6901600898603024391)
* [Flutter动态化框架Fair的设计与思考](https://juejin.cn/post/6896655572910014478)

## 🕰2020&2021 Roadmap

* 开源准备 2020
	* 项目清理 ✅
	* 对外文档准备 ✅
	* 官网准备 https://fair.58.com ✅
	* Github开源 https://github.com/wuba/fair ✅
  * i18n ⚠️✅
* Bug修复
	* Github issue处理
* 维护迭代 2021
	* Framework适配优化
	* 局部刷新支持 ✅
	* 状态库支持Provider
	* 独立cli工具
	* 转化优质Demo ✅
  * 动画支持的形式
  * Flutter Favorite Package支持
  * 其他Top UI Package支持
  * 逻辑组件优化 ✅
	* CI流程
	* 社区插件贡献方式

## ⚠️Unsupported Features
由于dart语法解析工作量奇大，逻辑运算均不支持，由逻辑运算延伸的表达式则更多。
下面是一些，不支持特性&已知问题：

* 逻辑表达式，比如加减乘除，字符拼接，循环遍历语法等
* 链式点语法，如：Colors.black.withOpacity(0.59)，Colors.xxx本身是支持的，但是再次转换透明的则不支持
* 匿名Builder函数，如ListView的的builder属于逻辑运算，需要封装为组件

## 🔧Contributing
通过[Issue](https://github.com/wuba/fair/issues)提交问题，贡献代码走Pull Request，管理员将对代码进行审核。

## LICENSE
Fair项目基于[BSD协议](LICENSE)开源。我们使用的更多依赖库详见pubspec.yaml

> 感谢UXD的**Kaibin**老师提供设计支持

