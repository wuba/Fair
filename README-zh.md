![social preview](social-dark.png)

<p align="center">
  <a href="https://pub.dev/packages/fair"><img src="https://img.shields.io/badge/pub-2.4.1-orange" alt="pub"></a>
  <a href="https://github.com/wuba/fair"><img src="https://img.shields.io/badge/platform-flutter-blue.svg" alt="github"></a>
  <a href="https://fair.58.com/"><img src="https://img.shields.io/badge/doc-fair.58.com-green.svg" alt="doc"></a>
  <a href="https://github.com/wuba/fair/LICENSE"><img src="https://img.shields.io/badge/license-BSD-green.svg" alt="license"></a>
  <a href="https://github.com/wuba/fair/actions"><img src="https://github.com/wuba/fair/workflows/build/badge.svg" alt="build"></a>
  <a href="https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge"><img src="https://badges.gitter.im/flutter_fair/community.svg" alt="Gitter"></a>
</p>

[简体中文](README-zh.md)|[English](README.md)

---

Fair是为Flutter设计的动态化框架，通过Fair Compiler工具对原生Dart源文件的自动转化，使项目获得动态更新Widget的能力。

**Fair 的接入和使用，建议大家阅读在线文档:**

> 在线文档：[https://fair.58.com/](https://fair.58.com/)

![](fair/what-is-fair.png)

Fair的UI渲染是无损的，可以做到像素级别的还原，看一张转义Best Flutter UI Templates部分页面后的效果：

![best-ui-template](best-ui-template.png)

> 使用的工程来自 https://github.com/mitesh77/Best-Flutter-UI-Templates


## 🏛 架构

![fair architecture](fair.png)

## 🚀 快速接入


简单几步，接入Fair.

**step1：同步fair工程代码**

推荐同步 [fair](https://github.com/wuba/fair) 相关代码，并且进行本地依赖：

同步方式:

```
git clone https://github.com/wuba/fair.git
```

**step2：在 `pubspec.yaml` 添加依赖**

将Fair工程和对应的业务工程放在同一个目录中，并添加依赖:

```yaml
# add Fair dependency
dependencies:
  fair: 2.4.1

# add build_runner and compiler dependency
dev_dependencies:
  build_runner: ^2.0.0
  fair_compiler:
    path: ../fair/compiler

# switch "fair_version" according to the local Flutter SDK version
# Flutter SDK 2.5.x(2.5.0、2.5.1、2.5.2、2.5.3) -> flutter_2_5_0
# Flutter SDK 2.0.6 -> flutter_2_0_6
# Flutter SDK 1.22.6 -> flutter_1_22_6
dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_2_5_0
```

**step3：将App替换为FairApp**

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

**step4：添加FairWidget作为动态Widget**

```dart
FairWidget(
name: 'DynamicWidget',
path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
data: {"fairProps": json.encode({})}),
```

## 🕰2022 规划

* 主版本计划
  * null-safe 版本支持，预计4月22日上线     ✅
  * Flutter 2.8.0版本适配，预计5月中旬上线  
  * Flutter 2.10.0版本适配，预计6月初上线
  * IDE 语法检测和提示插件
  * 丰富语法糖
* 热更新平台
  * Dart Server工程搭建   ✅
  * Flutter Web工程搭建   ✅
  * 补丁/资源管理
  * 项目管理
  * 移动端 Update&Download
* 线上动态化
  * Flutter Web工程搭建   ✅
  * Dart Server工程搭建   ✅
  * Action编辑
  * 代码编辑
  * 组件编辑
  * 页面编辑
  * 工程编辑
  * Flutter效果预览
  * Fair DSL预览

## ✨️ 贡献者

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://blog.hacktons.cn/"><img src="https://avatars.githubusercontent.com/u/1622234?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Wu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=avenwu" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=avenwu" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/LinLeyang"><img src="https://avatars.githubusercontent.com/u/13174498?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Penta</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=LinLeyang" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=LinLeyang" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/153493932"><img src="https://avatars.githubusercontent.com/u/10431131?v=4?s=100" width="100px;" alt=""/><br /><sub><b>haijun</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=153493932" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=153493932" title="Documentation">📖</a></td>
    <td align="center"><a href="https://yancechen.github.io/"><img src="https://avatars.githubusercontent.com/u/19757728?v=4?s=100" width="100px;" alt=""/><br /><sub><b>陈有余</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=yancechen" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=yancechen" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/yyzl0418"><img src="https://avatars.githubusercontent.com/u/14289945?v=4?s=100" width="100px;" alt=""/><br /><sub><b>yangyang</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=yyzl0418" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/wanbing"><img src="https://avatars.githubusercontent.com/u/7804234?v=4?s=100" width="100px;" alt=""/><br /><sub><b>wan</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=wanbing" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/bujiee"><img src="https://avatars.githubusercontent.com/u/16713978?v=4?s=100" width="100px;" alt=""/><br /><sub><b>bujie</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=bujiee" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/windkc"><img src="https://avatars.githubusercontent.com/u/59242966?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Kc</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=windkc" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/gongpengyang"><img src="https://avatars.githubusercontent.com/u/11691321?v=4?s=100" width="100px;" alt=""/><br /><sub><b>gongpengyang</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=gongpengyang" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/XIAOYUAOQISHI"><img src="https://avatars.githubusercontent.com/u/25222933?v=4?s=100" width="100px;" alt=""/><br /><sub><b>qixu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=XIAOYUAOQISHI" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/waynesonic"><img src="https://avatars.githubusercontent.com/u/5502794?v=4?s=100" width="100px;" alt=""/><br /><sub><b>waynesonic</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=waynesonic" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/paozhuanyinyu"><img src="https://avatars.githubusercontent.com/u/16041238?v=4?s=100" width="100px;" alt=""/><br /><sub><b>paozhuanyinyu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=paozhuanyinyu" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Alzzzz"><img src="https://avatars.githubusercontent.com/u/19664495?v=4?s=100" width="100px;" alt=""/><br /><sub><b>alzzzz</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=Alzzzz" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=Alzzzz" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## 👏🏻 支持
Star&Fork 是对我们最大的支持~

[![Stargazers repo roster for @wuba/fair](https://reporoster.com/stars/wuba/fair)](https://github.com/wuba/fair/stargazers)

[![Forkers repo roster for @wuba/fair](https://reporoster.com/forks/wuba/fair)](https://github.com/wuba/fair/network/members)

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
* [Fair 在 58 同城拍客 App 中的实践](https://mp.weixin.qq.com/s/_m6qN2OjbCK8ibBAyb2LYw)


## 🔧一起共建
通过[Issue](https://github.com/wuba/fair/issues)提交问题，贡献代码走Pull Request，管理员将对代码进行审核。

对Fair感兴趣的小伙伴，可以加入交流群。技术咨询、讨论，请移步至[![Gitter](https://badges.gitter.im/flutter_fair/community.svg)](https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

| 微信                         | 美事（内部）                 |
| ---------------------------- | ---------------------------- |
| ![wechat](./weixin.jpeg) | ![meishi](./meishi.jpeg) |

> 微信入群：请先添加58技术小秘书为好友，备注fair，小秘书邀请进群。


## ⚠️暂不支持功能
由于dart语法解析工作量奇大，会有部分语法和特殊使用方式的限制。
下面是一些，不支持特性&已知问题：
* 链式点语法，如：Colors.black.withOpacity(0.59)，Colors.xxx本身是支持的，但是再次转换透明的则不支持
* 类的继承不支持
  查阅更多不支持内容，请移步至[![Gitter](https://badges.gitter.im/flutter_fair/community.svg)](https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)


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

