## 平台简介

Fair 云开发平台是面向Flutter 开发者，提供从Fair 开发，到实时编译预览，最终打包发布的一体化云开发平台。它主要包含3部分：

- 云代码编辑器。提供给开发者进行在线代码编辑。
- 编译预览/打包发布。让开发者所见及所得。并且支持一键打包发布，实现Flutter线上动态化。
- 配套生态支持。提供常用的组件库、代码模板，用于提升开发效率，规范代码开发。

目前Fair 云开发平台已在Github 开源：
[fair-online github](https://github.com/wuba/Fair/tree/main/fair_online)

### 工程介绍

- fair_online 前端工程
- fair_online_service 后端服务
    - 后端服务运行 [简体中文](./fair_online_service/README-zh.md)|[English](./fair_online_service/README.md)

## 快速入门

### 工程创建

输入Fair 云开发平台网址：[fair-online.58.com](https://fair-online.58.com/) 进入平台首页。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670482262651-02c5e742-b456-451c-868d-21c50286216a.png#averageHue=%23e0e0c4&clientId=u1192a2c9-fa7f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=740&id=u84927b35&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1480&originWidth=2870&originalType=binary&ratio=1&rotation=0&showTitle=false&size=351815&status=done&style=none&taskId=uc9224cc8-bdb1-440e-99c8-245069a3a9a&title=&width=1435" width="70%">
</div>
</html>

点击开始使用，进入我的工程页面，如下图所示。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670467602451-79fc005f-b38a-4fcf-a3aa-c1df99c3ba69.png#averageHue=%23121312&clientId=u3751ae5b-051f-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=uc30d8a24&margin=%5Bobject%20Object%5D&name=project_create_1.png&originHeight=1460&originWidth=2860&originalType=binary&ratio=1&rotation=0&showTitle=false&size=533770&status=done&style=none&taskId=u8100bd6f-ba60-46ec-b417-46990dfce8d&title=" width="70%">
</div>
</html>

点击工程创建，弹出如下Dialog。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670577565604-babca9c0-ca81-4087-ac94-891ece3387b5.png#averageHue=%232a2c2f&clientId=u1782d64a-9af2-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=633&id=uae8e77b8&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1266&originWidth=1994&originalType=binary&ratio=1&rotation=0&showTitle=false&size=365730&status=done&style=none&taskId=u532c5c7b-b2b5-4aec-a2db-ce3d40296af&title=&width=997" width="70%">
</div>
</html>

输入工程名，选择空工程或者模板工程创建新工程，模板工程中包含13个代码模板。 工程创建成功后，即可进入工程编辑页面，如下图所示。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670468474618-9d5ffb63-f325-4c3c-984f-5048c01da8ae.png#averageHue=%23171d23&clientId=u3751ae5b-051f-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=u07a88724&margin=%5Bobject%20Object%5D&name=project_create_3.png&originHeight=1470&originWidth=2870&originalType=binary&ratio=1&rotation=0&showTitle=false&size=542591&status=done&style=none&taskId=u92ab85d8-7e99-4e3e-b2cb-88740178759&title=" width="70%">
</div>
</html>

### 页面创建

在工程编辑页面，点击左上方的页面创建，弹出页面创建Dialog。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670577626362-24ec96c2-2682-4054-9f5d-6820bb26a5fc.png#averageHue=%233d4346&clientId=u1782d64a-9af2-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=638&id=u9e4bcf2e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1276&originWidth=1988&originalType=binary&ratio=1&rotation=0&showTitle=false&size=1139618&status=done&style=none&taskId=u77dd3609-a818-4fd4-b601-b4463f20b87&title=&width=994" width="70%">
</div>
</html>

输入页面路径和页面名称，选择空页面或者模板页面创建新页面。 页面创建成功后，可在页面列表切换查看该工程下所有的页面。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670469509789-cb5b1f56-57f6-4242-bd62-1ec3d6c31e5d.png#averageHue=%23191c1f&clientId=ud981bec8-6e71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=460&id=ueda749a9&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1322&originWidth=632&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74777&status=done&style=none&taskId=u1e473722-d002-4d16-a77a-05d122b7a77&title=&width=220" width="30%">
</div>
</html>

### 代码编辑

#### 基本使用

代码编辑器可以在线编写Flutter、Fair代码，从左侧的页面菜单栏中点击选择需要编辑的页面，如下图所示选中了scrollview示例页面，右侧代码编辑区域会加载当前页面的代码，

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670574014734-d96f1041-7c8d-451e-b3f2-3a761c220212.png#averageHue=%23151a20&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=476&id=ua2bf64c4&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1536&originWidth=2220&originalType=binary&ratio=1&rotation=0&showTitle=false&size=496016&status=done&style=none&taskId=u66b26f40-a177-44a1-90fa-a172de81448&title=&width=688" width="70%">
</div>
</html>

代码编辑器支持代码提示，如下图所示，输入context变量后，输入 . 会像IDE一样列出context对象所有的方法调用。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670575014201-6b0d6ea7-2618-41a7-a8e3-d19f15fbd6e1.png#averageHue=%2367b981&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=327&id=u4ccfd219&margin=%5Bobject%20Object%5D&name=image.png&originHeight=966&originWidth=1370&originalType=binary&ratio=1&rotation=0&showTitle=false&size=294685&status=done&style=none&taskId=uf9b9b133-3111-4b15-bbcc-033fc5d50bf&title=&width=464" width="50%">
</div>
</html>

代码编辑器支持对Flutter以及Fair语法的检测，当检测出语法问题时会有类似IDE的代码划线警告，右下角有着具体语法错误分析弹窗，点击可以复制报错信息和跳转官方文档查看更多，底部面板点击hide按钮隐藏语法分析弹窗。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670574480084-61efb4fe-6a93-4760-97cd-90d54b78c1e9.png#averageHue=%23151c23&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=502&id=ue0004bf1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1590&originWidth=2184&originalType=binary&ratio=1&rotation=0&showTitle=false&size=512776&status=done&style=none&taskId=u4768985f-6a16-45ad-a14d-3d8e378f681&title=&width=689" width="50%">
</div>
</html>

Fair云开发平台还针对Fair一些特殊的语法做了支持，如图就是对build函数中不支持的 if else 逻辑控制语句显示警告。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670574682060-736beb67-2ab2-4eaa-afc6-54b23b498607.png#averageHue=%23111820&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=305&id=u044baeaa&margin=%5Bobject%20Object%5D&name=image.png&originHeight=718&originWidth=1168&originalType=binary&ratio=1&rotation=0&showTitle=false&size=199491&status=done&style=none&taskId=ueee749df-cfd5-4c08-888d-92e4199ffe0&title=&width=496" width="50%">
</div>
</html>

对于Flutter和Fair的语法错误提示，Fair云开发平台支持代码修复，使用 **[Control+Enter] **
快捷键即可修复代码问题。如下图所示，点击后会使用Fair内置的语法糖来解决逻辑控制语句的问题。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670574758151-6494a6f7-ef0a-493d-8577-5d33dde1a820.png#averageHue=%23131c27&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=335&id=ucf0e20fd&margin=%5Bobject%20Object%5D&name=image.png&originHeight=710&originWidth=1042&originalType=binary&ratio=1&rotation=0&showTitle=false&size=192107&status=done&style=none&taskId=u754e9035-90ff-4473-a361-4e5cb6d1397&title=&width=491" width="50%">
</div>
</html>

代码编辑器还支持代码辅助功能，对Widget对象使用 **[Control+Enter] **快捷键会有如图所示的提示选项，根据提示可以快捷的包裹常用控件，方便了使用者高效开发。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670575119066-68e15942-757b-4425-aad5-a5c9c8d4c0d0.png#averageHue=%23131c25&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=499&id=uf4be96da&margin=%5Bobject%20Object%5D&name=image.png&originHeight=928&originWidth=892&originalType=binary&ratio=1&rotation=0&showTitle=false&size=233418&status=done&style=none&taskId=u09241350-56f1-4eb0-8080-a90b3a39127&title=&width=480" width="50%">
</div>
</html>

#### 常用快捷键

| windows快捷键   | mac快捷键          | 动作   |
|--------------|-----------------|------|
| alt-enter    | option+enter    | 代码提示 |
| ctrl-space   | command-space   | 代码补全 |
| ctrl-enter   | command+enter   | 运行   |
| shift-ctrl-f | shift+command+f | 格式化  |

### Flutter 编译预览

开发过程中，可随时点击Run执行Flutter 编译预览，代码编辑阶段为了提升编译速度，快速预览编码效果，采用的是DDC(Dart Development Compiler)编译模式。
这里需要注意只有被@FairPreviewPage()注解修饰的Widget类可以被服务端识别并返回预览结果。 编译成功后，展示在线预览页面，点击开发对应的页面，查看页面效果。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670469777264-d20c4e0a-f0d9-4fce-a6b3-a5b943e9869f.png#averageHue=%23499f88&clientId=ud981bec8-6e71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=504&id=u469f8545&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1310&originWidth=780&originalType=binary&ratio=1&rotation=0&showTitle=false&size=86889&status=done&style=none&taskId=u2f5c59f8-d415-468f-a4dc-9aacc714749&title=&width=300" width="30%">
</div>
</html>

点击模拟器下方的Device Setting，可切换预览设备。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670470149888-1e5cc242-18cc-4600-8e99-92124299ac13.png#averageHue=%23363d3e&clientId=ud981bec8-6e71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=506&id=u1f7847ce&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1316&originWidth=780&originalType=binary&ratio=1&rotation=0&showTitle=false&size=332480&status=done&style=none&taskId=ubb8585b8-c88b-441e-8617-4da5dbe0dba&title=&width=300" width="30%">
</div>
</html>

如果编译失败，可在Console窗口查看错误日志。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670470520632-c990a883-fb2c-4859-95a0-c7f2a7de711b.png#averageHue=%2315181a&clientId=ud981bec8-6e71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=260&id=u7c9d912d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=520&originWidth=1274&originalType=binary&ratio=1&rotation=0&showTitle=false&size=185891&status=done&style=none&taskId=u7db31c79-c6be-45dd-9235-cf7041b3a38&title=&width=637" width="50%">
</div>
</html>

### Fair 编译预览

Fair 编译预览分为编译及预览两个步骤。 点击模拟器上方的Build，即可执行 Fair的编译。 编译成功后，可在左边的Fair DSL列表查看Fair 的编译产物。Fair 编译产物包括JSON
和JS 文件，可切换查看。 如果编译失败，可在下方Console 窗口查看日志信息。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670471071820-4cb091be-50dd-4f7d-ab97-ef604ffeb956.png#averageHue=%23171d23&clientId=u399af36e-dd07-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=735&id=u367fab51&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1470&originWidth=2868&originalType=binary&ratio=1&rotation=0&showTitle=false&size=541539&status=done&style=none&taskId=ubf0e380c-e696-4bb1-8802-bc3e5a7d8ae&title=&width=1434" width="70%">
</div>
</html>

编译成功后，点击模拟器上方的Run，执行Fair 预览。 点击Fair 预览-云开发平台使用，进入下图所示Fair DSL 列表。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670482445008-4f8a7777-dc16-4fbb-9fd4-1ec66cffb380.png#averageHue=%236a7e7a&clientId=u1192a2c9-fa7f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=524&id=u65c2bec0&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1352&originWidth=774&originalType=binary&ratio=1&rotation=0&showTitle=false&size=477362&status=done&style=none&taskId=ufd0a2dde-69b9-4efc-9230-73a5b27acdc&title=&width=300" width="40%">
</div>
</html>

点击选择Fair DSL，查看页面效果。

### 自定义组件

#### 创建与编辑

Fair云开发平台支持自定义组件，左侧面板点击下方添加图标打开自定义组件界面，如图所示列表中有内置的两个组件示例，在这个页面中可以创建新组件、编辑/删除已有的组件

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576058503-f5f2ec25-af96-482d-ba1f-3ebc89c47673.png#averageHue=%237b7e6f&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=1144&id=uc0bbcf80&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1144&originWidth=3004&originalType=binary&ratio=1&rotation=0&showTitle=false&size=253673&status=done&style=none&taskId=ud7d3ed6c-e510-4539-b2be-43c28436181&title=&width=3004" width="70%">
</div>
</html>

点击右上角添加组件打开组件编辑弹窗，可以在线编辑代码

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576150589-5da9a1ec-75a3-4f3b-895c-69a5f3196798.png#averageHue=%2356aa8b&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=1394&id=ud37b84da&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1394&originWidth=2552&originalType=binary&ratio=1&rotation=0&showTitle=false&size=334013&status=done&style=none&taskId=u45eed972-57c4-47a6-b15e-c9a488efc53&title=&width=2552" width="70%">
</div>
</html>

点击右上角编译预览按钮可以快速预览效果

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576368798-e2fbc675-03c3-4f53-ae63-16af3cb250f2.png#averageHue=%23697875&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=1394&id=u2a4f8da6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1394&originWidth=2492&originalType=binary&ratio=1&rotation=0&showTitle=false&size=976583&status=done&style=none&taskId=ufe959def-eea5-4298-89e3-3ed41a8c006&title=&width=2492" width="70%">
</div>
</html>

点击保存即可上传自定义组件

#### 使用

点击左侧面板中的自定义代码按钮，会列出当前的自定义组件列表

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576482199-66639ba5-e9f4-4bd8-82fd-ffab480b2832.png#averageHue=%23191f22&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=400&id=ZsGFI&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1062&originWidth=1078&originalType=binary&ratio=1&rotation=0&showTitle=false&size=194634&status=done&style=none&taskId=ucd5bb2d2-ed37-407a-8037-c923c54181d&title=&width=406" width="40%">
</div>
</html>

点击使用打开对组件详细说明的弹窗，弹窗内容包含名称，简介以及原始代码和FairWidget代码

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576559205-13b77957-fb65-4a4c-b4a5-767ab82f63ed.png#averageHue=%2313191e&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=459&id=u93443e8b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1490&originWidth=2478&originalType=binary&ratio=1&rotation=0&showTitle=false&size=415827&status=done&style=none&taskId=uc8dc09b9-9614-47eb-bca7-b0af7cfc608&title=&width=764" width="70%">
</div>
</html>

点击右下角的复制按钮可将FairWidget粘贴到代码编辑器中进行使用

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576661723-38f2c605-97ba-48e6-87e8-c8c72260eb4f.png#averageHue=%23111820&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=205&id=u2ea0b304&margin=%5Bobject%20Object%5D&name=image.png&originHeight=494&originWidth=1342&originalType=binary&ratio=1&rotation=0&showTitle=false&size=101127&status=done&style=none&taskId=uddab071d-c7ee-46ab-b1c3-91c25b53afc&title=&width=556" width="70%">
</div>
</html>

### 自定义Action

自定义Action可以方便使用者快速的粘贴工具代码以快速开发，具体的创建与编辑操作和自定义组件类似，如图所示是内置的FairNet网络请求Action

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576790410-04089a26-2d20-4f9d-8043-3aad9daed1d2.png#averageHue=%23191c1d&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=938&id=udcd28f21&margin=%5Bobject%20Object%5D&name=image.png&originHeight=938&originWidth=2966&originalType=binary&ratio=1&rotation=0&showTitle=false&size=125614&status=done&style=none&taskId=ue73be283-41ba-42d2-b5d7-0faa65a5d5e&title=&width=2966" width="70%">
</div>
</html>

使用方法同样也是粘贴到代码编辑器中

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/26469391/1670576818782-7defb6c9-8fbd-42bf-9cc7-62b1262cf64d.png#averageHue=%23141b21&clientId=u2b0b6c70-d8a1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=1492&id=u185307aa&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1492&originWidth=1948&originalType=binary&ratio=1&rotation=0&showTitle=false&size=424729&status=done&style=none&taskId=ue6d7b6d5-a1db-4bde-b0a3-6d538891a40&title=&width=1948" width="70%">
</div>
</html>

### 手机扫码预览

Fair 云开发平台支持手机扫码实时预览功能，移动端平台相关的功能，如打电话，定位等，可通过扫码在手机上实时预览。 点击工程编辑页面右上角的二维码样式按钮，弹出如下所示Dialog。 Fair
云开发平台提供了 FairPlayground APP，可通过点击如下链接下载安装。安装完成后，打开APP，进入Fair 开发者选项页面，点击扫一扫，扫码Dialog中的二维码，即可预览。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670577731073-b1792ccb-c1d3-4cb9-8278-c9d973a59e13.png#averageHue=%23223831&clientId=u1782d64a-9af2-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=593&id=u869a14bb&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1186&originWidth=1430&originalType=binary&ratio=1&rotation=0&showTitle=false&size=416480&status=done&style=none&taskId=ua2e7c8f0-eb80-43e4-8a09-8e8649551ef&title=&width=715" width="60%">
</div>
</html>

### 上传补丁

功能开发完成后，可在Fair 云开发平台上将编译产物上传至热更新平台。 点击右上角的更多菜单。

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670470729695-f6b5769d-e7b7-4956-8d59-29b90c5346c5.png#averageHue=%23292d31&clientId=ud981bec8-6e71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=138&id=ubfd5eb4e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=276&originWidth=382&originalType=binary&ratio=1&rotation=0&showTitle=false&size=48598&status=done&style=none&taskId=ub5825c0b-f4fc-45e4-a34e-6fea5ec29eb&title=&width=191" width="30%">
</div>
</html>

选择上传补丁，弹出如下所示Dialog。如果还没有搭建热更新平台，Fair 团队开源的FairPushy 了解一下~

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670577769927-79e10c7d-7132-4bf3-93be-0fa4d49f5342.png#averageHue=%23191d1d&clientId=u1782d64a-9af2-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=520&id=u1f04b808&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1040&originWidth=1992&originalType=binary&ratio=1&rotation=0&showTitle=false&size=107655&status=done&style=none&taskId=u46ae0af6-63ee-466a-8542-81f726ca70a&title=&width=996" width="70%">
</div>
</html>

### 工程导出

Fair 云开发平台支持将平台上开发的代码导出到本地。 点击右上角的更多菜单，选择工程导出，下载的是该工程代码的压缩包。

## 问题反馈

平台使用过程中，有任何的问题或者建议，欢迎扫码下方二维码，加入Fair 交流群交流沟通~

<html>
<div align="center">
<img src="https://cdn.nlark.com/yuque/0/2022/png/27688581/1670482744949-e30112ad-d713-4ece-9eca-6be10c632e62.png#averageHue=%23c0c0c0&clientId=u71d61e07-a467-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=463&id=u6ee47917&margin=%5Bobject%20Object%5D&name=image.png&originHeight=926&originWidth=720&originalType=binary&ratio=1&rotation=0&showTitle=false&size=2004403&status=done&style=none&taskId=u5d12e1b4-a80b-4b8f-935b-1dcad769081&title=&width=360" width="50%">
</div>
</html>

