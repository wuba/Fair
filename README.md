![social preview](social-dark.png)
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<p align="center">
  <a href="https://pub.dev/packages/fair"><img src="https://img.shields.io/badge/pub-3.2.1-orange" alt="pub"></a>
  <a href="https://github.com/wuba/fair"><img src="https://img.shields.io/badge/platform-flutter-blue.svg" alt="github"></a>
  <a href="https://fair.58.com/"><img src="https://img.shields.io/badge/doc-fair.58.com-green.svg" alt="doc"></a>
  <a href="https://github.com/wuba/fair/LICENSE"><img src="https://img.shields.io/badge/license-BSD-green.svg" alt="license"></a>
  <a href="https://github.com/wuba/fair/actions"><img src="https://github.com/wuba/fair/workflows/build/badge.svg" alt="build"></a>
  <a href="https://gitter.im/flutter_fair/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge"><img src="https://badges.gitter.im/flutter_fair/community.svg" alt="Gitter"></a>
</p>

[简体中文](README-zh.md)|[English](README.md)

---

Fair is a dynamic framework designed for Flutter. Through the automatic conversion of native Dart source files by the Fair Compiler tool, the project can obtain the ability to dynamically update the Widget Tree and State.

The goal of creating Fair is to support updates through business bundles and JS distribution without the release of versions (Android, iOS, Web), similar to React Native. After integrating with Flutter Fair, you can quickly publish new pages without waiting for your app's next release date. Fair provides standard widgets, which can be used as a new dynamic page or as part of an existing Flutter page, such as typography/style modification of operation bits, full page replacement, partial replacement, etc.

![](what-is-fair-en.png)

Fair's UI rendering is lossless and can be restored at the pixel level. Take a look at the effect of escaping some pages of Best Flutter UI Templates:

![best-ui-template](best-ui-template.png)

> The project used is from https://github.com/mitesh77/Best-Flutter-UI-Templates </br>
> location：/example/lib/best_flutter_ui

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
  fair: 3.2.1

# add build_runner and compiler dependency
dev_dependencies:
  build_runner: ^2.0.0
  fair_compiler: ^1.7.0
 
# switch "fair_version" according to the local Flutter SDK version
# Flutter SDK 3.7.x(3.7.0、3.7.1、3.7.2、3.7.3、3.7.4、3.7.5、3.7.6、3.7.7、3.7.8、3.7.9、3.7.10) -> flutter_3_7_0
# Flutter SDK 3.3.x(3.3.0、3.3.1、3.3.2、3.3.3、3.3.4、3.3.5、3.3.6、3.3.7、3.3.8、3.3.9、3.3.10) -> flutter_3_3_0
# Flutter SDK 3.0.x(3.0.0、3.0.1、3.0.2、3.0.3、3.0.4、3.0.5) -> flutter_3_0_0
# Flutter SDK 2.10.x(2.10.0、2.10.1、2.10.2、2.10.3) -> flutter_2_10_0
# Flutter SDK 2.8.x(2.8.0、2.8.1) -> flutter_2_8_0
# Flutter SDK 2.5.x(2.5.0、2.5.1、2.5.2、2.5.3) -> flutter_2_5_0
# Flutter SDK 2.0.6 -> flutter_2_0_6
# Flutter SDK 1.22.6 -> flutter_1_22_6
dependency_overrides:
  fair_version:
    path: ../fair/flutter_version/flutter_3_7_0
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

## DevTools
fair development tools
### Dart Commandline Tool [faircli](https://pub.dev/packages/faircli)

create fair project

**faircli install**
```dart
dart pub global activate faircli
```

**create fair dynamic project**
```dart
faircli create -n dynamic_project_name
```
**create fair carrier project**
```dart
faircli create -k carrier -n carrier_project_name
```

### IDEA Plugin [FairTemplate](https://plugins.jetbrains.com/plugin/20323-fairtemplate)

Page/Component Template Code

<html>
<img src="fair_template.png" width="80%">
</html>

### DevTools flow chart
![fair tools](fair_tools.png)

### DevTools demo
After using faircli to configure the local hot update service, open the developer options on the mobile device, select the local mode, enter the ip of the development machine, then preview fair dynamic effect

<html>
<div align="center">
<img src="fair_tools.gif" width="30%">
</div>
</html>

For more details, please refer to [fair_tools](fair_tools.md)

## Fair-Online Platform
Fair-Online is an integrated cloud development platform for Flutter developers, from online development of Flutter, to real-time compilation and preview, packaging and publishing, and dynamic release of end-side updates, to realize the dynamic online Flutter.

Developers do not need to configure the Flutter development environment, develop and debug code online, compile and preview in real time, and what you see is what you get. Combined with the Flutter dynamic framework Fair and the hot update platform FairPushy created by the 58 open source team, Flutter online dynamics are realized.

<html>
<div align="center">
<img src="./fair_online/fair_online.gif" width="90%">
</div>
</html>

Online experience URL:
[Fair-Online Platform](https://fair-online.58.com/)

For more details, please refer to [fair_online](./fair_online/README.md)

## Documentation
For more details, please refer to [https://fair.58.com](https://fair.58.com)  
### Tools
Fair Cli: [Fair_CLI](https://pub.dev/packages/faircli)  
IEDA plugin: [jetbrains_plugin_fair_template](https://plugins.jetbrains.com/plugin/20323-fairtemplate)  
Hot update platform: [FAIR PUSHY](https://github.com/wuba/FairPushy)

## versions

### 3.2.1
updateDate：2023.04.13

- Fixed some issues.

### 3.2.0
updateDate：2023.04.12

- Adjust the order of dispose calls, not above the tree, subsequent operations stop
- Add generic FairPlugin js and dart code, reuse the same interaction logic, add example comments
- Json parsing compatibility
- Add exception catching and log printing when executeFunction is called with V8 engine in Android
- Fix SliverGridDelegateWithFixedCrossAxisCount conversion error.
- SugarMap and SugarMapEach inputs support other Sugar expressions
- Optimize the performance of ifEqual ifEqualBool switchCase
- Fix Domain not recognizing index and item in sugar
- Make AOT also follow conditions before executing code
- Fix SugarMap and SugarMapEach set input does not support other Sugar syntax
- Abstract Domain, add IndexDomain, MapEachDomain, support nested Domains
- New FunctionDomain generic Domain, generate corresponding parameters for function callbacks for FunctionDomain to use.
- Added NullableIndexedWidgetBuilder, IndexedWidgetBuilder, WidgetBuilder, TransitionBuilder common Sugar support
- Some known issues fixed

### 3.1.0
updateDate：2023.03.14

- Upgrade analyzer library to 5.5.0;
- Dart function to JS supports parameter passing;
- JS Object value compatibility;
- Remove kotlin dependencies from fair/android;
- Add custom parsing for IconData;
- The generation of optional positional parameters is modified to obtain pa;
- Fixed missing OptionalPositional default values;
- Remove the generation time from the generation.fair. dart comment;
- Added the ignore unnecessary_import operation;
- Fixed incorrect assignment of Sugar.switchCase key and defaultValue;
- binding was changed to SplayTreeMap to increase search efficiency, especially for lists, where duplicate tags are searched for a short time;
- Exposing specialBinding so that users can override a value;
- When the provider is added to the _binding, the Settings set by the user prevail for quick modification;
- Fixed the loadCoreJs package splicing problem;
- Reduced minSdkVersion to 16;
- runApplication supports specifying the package in which the JS resides;
- Fixed error in calling context in the _reload method.

### 3.0.0
updateDate：2022.11.17

- Fix class constructor parsing exception.
- Fair Compatible Web.
- Bindmap logic optimization.

### 2.8.1
updateDate：2022.11.01

- Fixed：CustomScrollView reference external function builder bug.

### 2.8.0
updateDate：2022.10.21

- Add support of Flutter SDK 3.3.0+.
- Add Sugar：Sugar.isNestedScrollViewHeaderSliversBuilder、Sugar.isButtonStyle、Sugar.isDuration、Sugar.popMenuButton、Sugar.sliverChildBuilderDelegate、Sugar.sliverGridDelegateWithFixedCrossAxisCount.
- Fixed some bugs.

### 2.7.0
updateDate：2022.08.10

- Add support of Flutter SDK 3.0.0、3.0.1、3.0.2、3.0.3、3.0.4、3.0.5.
- Fixed some bugs.

#### Fair
- Fair supports loading bundle files on the phone disk path;
- Adapt to Flutter SDK 2.10.0, 2.10.1, 2.10.2, 2.10.3;
- Dart2JS supports parsing static methods;
- When running, the page error message prompts optimization;
- Syntactic sugar supports parsing Model data.

### 2.6.0
updateDate：2022.07.05

#### Fair
- Fair supports loading bundle files on the phone disk path;
- Adapt to Flutter SDK 2.10.0, 2.10.1, 2.10.2, 2.10.3;
- Dart2JS supports parsing static methods;
- When running, the page error message prompts optimization;
- Syntactic sugar supports parsing Model data.

### 2.5.0
updateDate：2022.05.31
#### Fair
Adapt to flutter SDK 2.8.0, 2.8.1  
Dart2js supports parsing singletons  
New syntax Sugar.switchCase、Sugar.colorsWithOpacity、Sugar.convertToString, etc  
#### example
Comprehensively optimize the example structure and upgrade the example experience, which is more suitable for beginners.  

In the source code, an example project is added to provide the standard usage of fair API.  

example location：`fair/example`

### v2.4.1
updateDate：2022.05.12  

Fix FairLogger import problem.  
Upgrade Analyzer to 2.3.0.  

### v2.4.0
updateDate：2022.04.26

FlatBuffers supports generating bin files in a null safe environment  

### v2.3.0
updateDate: 2022.04.22

#### Fair
supports null-safe  
Adapt to Flutter SDK 2.5.0, 2.5.1, 2.5.2, 2.5.3 and other versions  
#### demo
Upgrade the outdated demo in the sample project  
Supplement the iOS runtime environment in the sample project  

## 🕰2022 Roadmap

* Major release plan
   * null-safe version support, expected to be launched on April 22 ✅
   * Flutter 2.8.0 version adaptation, expected to be launched in mid-May ✅
   * Flutter 2.10.0 version adaptation, is expected to be launched in early June  ✅
   * Flutter 3.0 version adaptation               ✅
   * IDE syntax detection and hint plugin ✅
   * Rich syntactic sugar
* Hot update platform
   * Dart Server project construction ✅
   * Flutter Web project construction ✅
   * Patch/resource management         ✅
   * Project management                ✅
   * Mobile Update&Download           ✅
* Online dynamic
   * Flutter Web project construction ✅
   * Dart Server project construction ✅
   * ActionEdit
   * Code editing                     ✅
   * Component editing
   * Page editing
   * Engineering editor
   * Flutter effect preview
   * Fair DSL preview
* IDE plug-in
   * Fair project generation
   * Fair template generation
   * Fair syntax detection


## 📱Accessed APPs
<table>
  <tr>
    <td align="center"><img src="https://pic3.58cdn.com.cn/nowater/frs/n_v303052b2c3f3b4ea5a5989f5e52d71481.jpg" width="100px;" alt=""/><br /><sub><b>58阿姨</b></sub><br /></td>
    <td align="center"><img src="https://pic5.58cdn.com.cn/nowater/frs/n_v3ba05182f1dc9460dab8e02d22914f700.jpg" width="100px;" alt=""/><br /><sub><b>移动经纪人</b></sub><br /></td>
    <td align="center"><img src="https://pic7.58cdn.com.cn/nowater/frs/n_v35eecf738ac6c4ec992bfc0d1b8d910d4.jpg" width="100px;" alt=""/><br /><sub><b>安居拍房</b></sub><br /></td>
    <td align="center"><img src="https://pic1.58cdn.com.cn/nowater/frs/n_v3b4fd1abf1e484d3da864a177a12a28e2.jpg" width="100px;" alt=""/><br /><sub><b>神奇保</b></sub><br /></td>
    <td align="center"><img src="https://pic6.58cdn.com.cn/nowater/frs/n_v36e650b70b7834204959547bf616869ef.jpg" width="100px;" alt=""/><br /><sub><b>58商办通</b></sub><br /></td>
    <td align="center"><img src="https://pic1.58cdn.com.cn/nowater/frs/n_v378fdb523858b4475b05fb04f66f105ae.jpg" width="100px;" alt=""/><br /><sub><b>58商家版</b></sub><br /></td>
    <td align="center"><img src="https://pic6.58cdn.com.cn/nowater/frs/n_v31394c57d6c234aecad820c94dd1c8dc6.png" width="100px;" alt=""/><br /><sub><b>中华英才网</b></sub><br /></td>
  </tr>
</table>

## ✨Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/gongpengyang"><img src="https://avatars.githubusercontent.com/u/11691321?v=4?s=100" width="100px;" alt=""/><br /><sub><b>gongpengyang</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=gongpengyang" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/XIAOYUAOQISHI"><img src="https://avatars.githubusercontent.com/u/25222933?v=4?s=100" width="100px;" alt=""/><br /><sub><b>qixu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=XIAOYUAOQISHI" title="Code">💻</a></td>
    <td align="center"><a href="https://yancechen.github.io/"><img src="https://avatars.githubusercontent.com/u/19757728?v=4?s=100" width="100px;" alt=""/><br /><sub><b>陈有余</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=yancechen" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/yyzl0418"><img src="https://avatars.githubusercontent.com/u/14289945?v=4?s=100" width="100px;" alt=""/><br /><sub><b>yangyang</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=yyzl0418" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/wanbing"><img src="https://avatars.githubusercontent.com/u/7804234?v=4?s=100" width="100px;" alt=""/><br /><sub><b>wan</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=wanbing" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/bujiee"><img src="https://avatars.githubusercontent.com/u/16713978?v=4?s=100" width="100px;" alt=""/><br /><sub><b>bujie</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=bujiee" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/windkc"><img src="https://avatars.githubusercontent.com/u/59242966?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Kc</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=windkc" title="Code">💻</a></td>
    <td align="center"><a href="http://blog.hacktons.cn/"><img src="https://avatars.githubusercontent.com/u/1622234?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Wu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=avenwu" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=avenwu" title="Documentation">📖</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/LinLeyang"><img src="https://avatars.githubusercontent.com/u/13174498?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Penta</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=LinLeyang" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=LinLeyang" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/153493932"><img src="https://avatars.githubusercontent.com/u/10431131?v=4?s=100" width="100px;" alt=""/><br /><sub><b>haijun</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=153493932" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=153493932" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/waynesonic"><img src="https://avatars.githubusercontent.com/u/5502794?v=4?s=100" width="100px;" alt=""/><br /><sub><b>waynesonic</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=waynesonic" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/paozhuanyinyu"><img src="https://avatars.githubusercontent.com/u/16041238?v=4?s=100" width="100px;" alt=""/><br /><sub><b>paozhuanyinyu</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=paozhuanyinyu" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Alzzzz"><img src="https://avatars.githubusercontent.com/u/19664495?v=4?s=100" width="100px;" alt=""/><br /><sub><b>alzzzz</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=Alzzzz" title="Code">💻</a> <a href="https://github.com/wuba/fair/commits?author=Alzzzz" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/xiangwc"><img src="https://avatars.githubusercontent.com/u/22017021?v=4?s=100" width="100px;" alt=""/><br /><sub><b>xiangwc</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=xiangwc" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/KKProject"><img src="https://avatars.githubusercontent.com/u/14860258?v=4?s=100" width="100px;" alt=""/><br /><sub><b>WangYk</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=KKProject" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/JunZiJianYi"><img src="https://avatars.githubusercontent.com/u/34125737?v=4?s=100" width="100px;" alt=""/><br /><sub><b>SunWei</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=JunZiJianYi" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/shanpengtao"><img src="https://avatars.githubusercontent.com/u/7127463?v=4?s=100" width="100px;" alt=""/><br /><sub><b>单鹏涛</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=shanpengtao" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/lswc225"><img src="https://avatars.githubusercontent.com/u/16609338?v=4?s=100" width="100px;" alt=""/><br /><sub><b>lswc225</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=lswc225" title="Code">💻</a></td>
    <td align="center"><a href="http://www.gaofeiyu.com/"><img src="https://avatars.githubusercontent.com/u/6150536?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Goofy</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=gaofeiyu" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/itzhaoqian"><img src="https://avatars.githubusercontent.com/u/23277488?v=4?s=100" width="100px;" alt=""/><br /><sub><b>itzhaoqian</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=itzhaoqian" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/xxliang"><img src="https://avatars.githubusercontent.com/u/5005255?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Sunlight Xie</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=xxliang" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/a303268287"><img src="https://avatars.githubusercontent.com/u/19368353?v=4?s=100" width="100px;" alt=""/><br /><sub><b>lhdycxgghb</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=a303268287" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/hlwhl"><img src="https://avatars.githubusercontent.com/u/7610615?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Prome</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=hlwhl" title="Code">💻</a></td>
    </td>
    <td align="center"><a href="https://github.com/hlwhl"><img src="https://avatars.githubusercontent.com/u/16477333?v=4" width="100px;" alt=""/><br /><sub><b>zmtzawqlp</b></sub></a><br /><a href="https://github.com/wuba/fair/commits?author=zmtzawqlp" title="Code">💻</a></td>
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
