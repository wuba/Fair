![social preview](social-dark.png)
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<p align="center">
  <a href="https://pub.dev/packages/fair"><img src="https://img.shields.io/badge/pub-2.4.0-orange" alt="pub"></a>
  <a href="https://github.com/wuba/fair"><img src="https://img.shields.io/badge/platform-flutter-blue.svg" alt="github"></a>
  <a href="https://fair.58.com/"><img src="https://img.shields.io/badge/doc-fair.58.com-green.svg" alt="doc"></a>
  <a href="https://github.com/wuba/fair/LICENSE"><img src="https://img.shields.io/badge/license-BSD-green.svg" alt="license"></a>
  <a href="https://github.com/wuba/fair/actions"><img src="https://github.com/wuba/fair/workflows/build/badge.svg" alt="build"></a>
  <a href="https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge"><img src="https://badges.gitter.im/flutter_fair/community.svg" alt="Gitter"></a>
</p>

[简体中文](README-zh.md)|[English](README.md)

---

Fair is a lightweight package for Flutter, which can be used to update widget tree and state dynamically. This package is still at an early stage.

We create Fair so we can dispatch any pages changes to users as bundle(s), the way similar to React Native. With Flutter Fair integrated, you can publish your pages without waiting for the next release date of your App. Fair provides standard widget and some logic plugins, it can be used as a new dynamic page or as part of existing Flutter page.

![](fair/what-is-fair-en.png)

## 🏛Architecture

![fair architecture](fair.png)

## 🚀 Running
Use Flutter Fair require few steps. 

**step1：download fair project source code**

It is recommended to download [fair](https://github.com/wuba/fair) to the local and dependencies on the relative path. 

The download method is as follows:

```
git clone https://github.com/wuba/fair.git
```

**step2：Add dependency inside `pubspec.yaml`**

Assuming that the fair project and your own project are in the same folder:

```yaml
# add Fair dependency
dependencies:
  fair: 2.4.0

# add compiler dependency
dev_dependencies:
  build_runner: ^2.0.0
  fair_compiler:
    path: ../fair/compiler
 
# switch "fair_version" according to the local Flutter SDK version.
# Flutter SDK 2.5.x(2.5.0、2.5.1、2.5.2、2.5.3) -> fair_version: 2.5.0
# Flutter SDK 2.0.6 -> fair_version: 2.0.6+1
# Flutter SDK 1.22.6 -> fair_version: 1.22.6
dependency_overrides:
  fair_version: 2.0.6+1
```

**step3：Wrap your app with FairApp Widget**

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

**step4：Import a dynamic widget as FairWidget**

```dart
FairWidget(
  name: 'DynamicWidget',
  path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
  data: {"fairProps": json.encode({})}),
```

## Documentation
For more details, please refer to [https://fair.58.com](https://fair.58.com)

## 🕰2022 Roadmap

* Major release plan
   * null-safe version support, expected to be launched on April 22 ✅
   * Flutter 2.8.0 version adaptation, expected to be launched in mid-May
   * Flutter 2.10.0 version adaptation, is expected to be launched in early June
   * IDE syntax detection and hint plugin
   * Rich syntactic sugar
* Hot update platform
   * Dart Server project construction ✅
   * Flutter Web project construction ✅
   * Patch/resource management
   * Project management
   * Mobile Update&Download
* Online dynamic
   * Flutter Web project construction ✅
   * Dart Server project construction ✅
   * ActionEdit
   * Code editing
   * Component editing
   * Page editing
   * Engineering editor
   * Flutter effect preview
   * Fair DSL preview

## ✨Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/gongpengyang"><img src="https://avatars.githubusercontent.com/u/11691321?v=4?s=100" width="100px;" alt=""/><br /><sub><b>gongpengyang</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=gongpengyang" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/XIAOYUAOQISHI"><img src="https://avatars.githubusercontent.com/u/25222933?v=4?s=100" width="100px;" alt=""/><br /><sub><b>qixu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=XIAOYUAOQISHI" title="Code">💻</a></td>
    <td align="center"><a href="https://yancechen.github.io/"><img src="https://avatars.githubusercontent.com/u/19757728?v=4?s=100" width="100px;" alt=""/><br /><sub><b>陈有余</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=yancechen" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=yancechen" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/yyzl0418"><img src="https://avatars.githubusercontent.com/u/14289945?v=4?s=100" width="100px;" alt=""/><br /><sub><b>yangyang</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=yyzl0418" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/wanbing"><img src="https://avatars.githubusercontent.com/u/7804234?v=4?s=100" width="100px;" alt=""/><br /><sub><b>wan</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=wanbing" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/bujiee"><img src="https://avatars.githubusercontent.com/u/16713978?v=4?s=100" width="100px;" alt=""/><br /><sub><b>bujie</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=bujiee" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/windkc"><img src="https://avatars.githubusercontent.com/u/59242966?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Kc</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=windkc" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="http://blog.hacktons.cn/"><img src="https://avatars.githubusercontent.com/u/1622234?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Wu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=avenwu" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=avenwu" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/LinLeyang"><img src="https://avatars.githubusercontent.com/u/13174498?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Penta</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=LinLeyang" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=LinLeyang" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/153493932"><img src="https://avatars.githubusercontent.com/u/10431131?v=4?s=100" width="100px;" alt=""/><br /><sub><b>haijun</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=153493932" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=153493932" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/waynesonic"><img src="https://avatars.githubusercontent.com/u/5502794?v=4?s=100" width="100px;" alt=""/><br /><sub><b>waynesonic</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=waynesonic" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/paozhuanyinyu"><img src="https://avatars.githubusercontent.com/u/16041238?v=4?s=100" width="100px;" alt=""/><br /><sub><b>paozhuanyinyu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=paozhuanyinyu" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Alzzzz"><img src="https://avatars.githubusercontent.com/u/19664495?v=4?s=100" width="100px;" alt=""/><br /><sub><b>alzzzz</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=Alzzzz" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=Alzzzz" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/xiangwc"><img src="https://avatars.githubusercontent.com/u/22017021?v=4?s=100" width="100px;" alt=""/><br /><sub><b>xiangwc</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=xiangwc" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## 👏🏻Supporters

[![Stargazers repo roster for @wuba/fair](https://reporoster.com/stars/wuba/fair)](https://github.com/wuba/fair/stargazers)

[![Forkers repo roster for @wuba/fair](https://reporoster.com/forks/wuba/fair)](https://github.com/wuba/fair/network/members)

## License

Copyright (C) 2005-present, 58.com.  All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of 58.com nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.