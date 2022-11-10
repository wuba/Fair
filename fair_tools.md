### 项目背景

当前Fair在使用上有着一定的门槛，新接触的小伙伴一般是阅读使用指南来上手Fair，大致需要经过下面的几个步骤

1. 创建工程，配置依赖
2. 编写Fair代码，手动编译动态化产物
3. 将编译产物手动拷出，通过文件或者网络的方式加载
4. 安装预览效果

如果需要更新动态化产物重新预览效果的话，就要重复234步骤，这样对于上手的过程是极不方便的，我们在开源社区收到的反馈中也有很大一部分是有关基础使用。

研发Fair配套工具链是为了辅助开发者快速上手 Fair开发，提升Fair开发效率，规避Fair不支持的Flutter语法，主要包含三个部分：

- 工程创建：快速搭建Fair载体工程及动态化工程
- 模板代码：提供页面及组件模板
- 本地热更新：线下开发使用，实现开发阶段快速预览Fair动态化功能

我们以dart命令行工具及AS插件的形式提供给开发者使用。

### 流程图

> 使用流程图如下：

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_Xd7b37VaU5d35a35d3Wc137bWcXU5a5a.png" width="90%">
</div>
</html>

### 使用说明

#### 步骤一：工具安装

##### 安装 Faircli 命令行工具

```Dart
dart pub global activate faircli
```

##### 安装 AS 插件

现在已上传插件市场。可从/Android Studio/Preference/Plugins 搜索 "FairTemplate" 安装。

准备工作完成后，下面进入开发使用流程。

#### 步骤二：Faircli-工程创建

工程分为载体工程及动态化工程。动态化的功能模块需要在动态化工程中开发。载体工程提供 bundle 下载、加载及基础能力支持。

##### 创建动态化工程

```Dart
faircli create -n dynamic_project_name
```

dynamic_project_name: 动态化工程名

##### 创建载体工程

```Dart
faircli create -k carrier -n carrier_project_name
```

carrier_project_name: 载体工程名

##### 使用演示

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_377bV9V913WcWcU57bXdU735U75a13Xd.gif" width="70%">
</div>
</html>

#### 步骤三：IDE插件-功能开发

##### 模板代码使用

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_5913d3Xd7b13Vad35aU5Va35d37b35Xd.png" width="60%">
</div>
</html>

选择代码模板，生成对应的代码文件。

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_XdVa3737WbU55aVa135a373735d3XUd3.png" width="70%">
</div>
</html>

在生成的代码中，进行二次开发。

##### 一键打包

功能开发完成后，可使用 AS 插件进行一键打包。

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_13U5d3V9V9U7d337Xdd137U559XUXd35.png" width="70%">
</div>
</html>

#### 步骤四：启动本地热更新服务

打包完成之后，可启动本地热更新服务，进行开发功能预览。

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_7bVa5aXd35d3U57bd15aU77bWb35WbXd.png" width="70%">
</div>
</html>

当控制台打印如下信息，表示成功启动本地热更新服务。

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_37Wb5a5aV9U713XU59XU595a7bVa7b35.png" width="70%">
</div>
</html>

##### 开发者选项

运行载体工程，进入开发者选项页面。

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_Wc3735VaWcV9Wc597b595a3559Wc5ad3.png" width="40%">
</div>
</html>

输入 host，加载 bundle 列表。选择对应的 bundle，进行功能预览。
手机摇一摇，可触发重新加载功能。

#### 步骤五：IDE插件-上传 bundle 到线上环境

<html>
<div align="center">
<img src="https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_U5U759d3d3U559355937d3XdWcd1Xdd3.png" width="70%">
</div>
</html>

### 使用效果

当使用faircli工具配置好本地的热更服务后，在移动设备上打开开发者选项，选择本地模式，输入电脑ip地址，就可以预览fair动态化效果

<html>
<div align="center">
<img src="fair_tools.gif" width="50%">
</div>
</html>