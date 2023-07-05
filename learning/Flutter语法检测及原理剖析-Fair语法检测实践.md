![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/6e3a381a-0e1e-4ab0-ab97-2a187f42300eimage.png)

## 前言

Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。

Fair是58技术开源的一个Flutter动态化的框架，能够实现UI和逻辑的动态化。
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/835d92b8-47d1-45e1-9fb7-74f93895d42fimage.png)


![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/3f124264-7bbf-4965-be62-ea7f259d6e27image.png)

开发者在使用Fair开发过程中存在一些痛点，比如可能会出现使用语法糖不正确或者存在不支持的语法糖问题，所以我们需要一个配套插件去提示用户使用Fair语法糖。

## 一、Flutter语法检测机制
在IDE中，Flutter语法检测机制是依赖Dart/Flutter插件实现的，即我们在开发Flutter前需要下载的Dart/Flutter插件。我们需要通过插件去提供Flutter的开发环境，同时插件也能提供语法检测功能。而插件其中的一个核心功能就是Analysis Server。

### Analysis Server是什么？
Analysis Server是Dart SDK提供的一个Dart/Flutter语法分析服务，主要功能包括语法静态分析、代码提示、代码补全等。我们常用的Dart/Flutter IDE如intellij、Android Studio和VS Code都是通过安装Dart插件实现Dart开发环境的配置。

### Dart/Flutter插件语法检测的工作流程
以Android Studio为例（因为对应插件的语言是Java，比较好阅读和理解），语法检测核心是Analysis Server，每当用户代码有改动的时候，就会通过Socket的方式同步给Analysis Server，当Analysis Server分析结束后也会将分析结果返回来，Dart插件则就是根据Analysis Server返的事件类型去做不同的处理，最终将结果刷新在用户IDE界面上。流程图如下：

![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/08a58f59-b025-4cf2-9d24-85e467487c22image.png)


### Dart插件中Analysis Server的启动流程
当用户配置完Dart SDK路径后，插件会获取到配置路径，在插件启动的时候会启动一个进程去执行Dart SDK里的dart可执行文件，同时也会获取到Dart SDK目录下的"/bin/snapshots/analysis_server.dart.snapshot"文件，并将其路径作为vmArguments。我们可以看一小段代码：
```Java

//获取配置的SDK路径
mySdkHome = sdk.getHomePath();

//找到dart可执行文件的路径
final String runtimePath = FileUtil.toSystemDependentName(DartSdkUtil.getDartExePath(sdk));

//找到analysis_server.dart.snapshot文件路径
String analysisServerPath = FileUtil.toSystemDependentName(mySdkHome + "/bin/snapshots/analysis_server.dart.snapshot");

//拼凑vmArguments
String firstArgument = useDartLangServerCall ? "language-server" : analysisServerPath;

//创建Socket
myServerSocket =
        new StdioServerSocket(runtimePath, StringUtil.split(vmArgsRaw, " "), firstArgument, StringUtil.split(serverArgsRaw, " "), debugStream);

//创建AnalysisServer实现类
final RemoteAnalysisServerImpl startedServer = new RemoteAnalysisServerImpl(myServerSocket);

//这里的具体实现其实就是socket.start()，将socket启动起来
startedServer.start();
```

### Dart插件与Analysis Server交互
Dart插件与Analysis Server交互类型主要分为两种，一种是id，一种是event。每次Dart插件给Analysis Server同步数据时都会生成一个uniqueId并缓存在HashMap，每次Analysis Server返数据的时候也会带上event或id，优先处理event类型数据。

Dart插件同步给Analysis Server数据示例：
```
request: {
  "id": String
  "method": "analysis.setAnalysisRoots"
  "params": {
    "included": List&lt;FilePath&gt;
    "excluded": List&lt;FilePath&gt;
    "packageRoots": optional Map&lt;FilePath, FilePath&gt;
  }
}
```

上述说到Dart插件每次给Analysis Server同步数据都会生成一个uniqueId，这里的生成规则就是通过具备原子属性的AtomicInteger的getAndIncrement()方法每同步一次数据+1。Dart插件对应Analysis Server每种事件实现一个Consumer或Processor(如果是event类型数据则是Processor，result事件类型的话就是Consumer)。


### 语法检测插件的挂载流程
插件是有一个挂载过程的，插件的挂载流程如下图所示:
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/78f5e43f-b7ba-46a8-a178-4adc679d3d1bimage.png)

**小结一下：**
  1. YamlParaser解析analysis_options.yaml文件中analyzer#plugins节点，获取到一个pluginNameList
  2. 根据pluginNameList遍历通过Plugin Locator获取到每个plugin的analyzer_plugin目录路径，即pluginPath
  3. 将pluginPath目录路径文件copy到系统的.dartServer/plugin_manager/unique Directory目录下，其中unique Directory是通过对pluginPath进行md5操作生成的串
  4. 执行pluginPath下/bin/plugin.dart的main方法
  


## 二、Fair语法检测插件的实现原理
当我们掌握了前面的前置知识，再去开发语法插件就简单许多了。

### Fair语法检测插件的实现机制
Dart插件是基于Analysis Server实现了Dart语法的检测，Fair语法检测插件则是对Dart插件语法检测功能的补充和扩展，实现对Fair语法糖的检测，Fair语法插件本质页是一个Dart语法检测插件，可以通过配置pubspec.yaml和analysis_options.yaml来使用。
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/04b254f0-177f-4291-80e3-a6ba0fb1f630image.png)


### 语法插件的开发流程
主要可以分为以下几步：
1. 首先创建一个类去继承ServerPlugin，并实现抽象属性/方法。
2. 然后跟lib同级创建tools/analyzer_plugin目录，内容如图所示:
 ![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/b2db3ef3-0b3c-46d1-9947-df7c111cf837image.png)
3. 最后在plugin.dart文件中注册步骤1中实现的ServerPlugin。
```Dart
//示例
void main(List<String> args, SendPort sendPort) {
	ServerPluginStarter(FairPlugin(PhysicalResourceProvider.INSTANCE)).start(sendPort);
}

```


### 核心实现
Fair语法检测插件的核心就是抽象语法树遍历，通过对抽象语法树的遍历，获取到每个子节点，然后插入自定义语法检测逻辑。

#### 1.创建AnalysisDriver
createAnalysisDriver()是ServerPlugin的一个抽象方法，开发者实现这个方法创建一个AnalysisDriver，然后我们可以通过AnalysisDriver的results数据流去监听AnalysisResult的返回，其中这个AnalysisResult就是Analysis Server对文件的分析结果。示例代码如下所示：
```Dart
@override
AnalysisDriverGeneric createAnalysisDriver(plugin.ContextRoot contextRoot) {

	//获取contextRoot
	final contextRoots =
        ContextLocator(resourceProvider: resourceProvider).locateRoots(...);
	
	//获取ContextBuilder
	final contextBuilder =
        ContextBuilderImpl(resourceProvider: resourceProvider);
	
	//获取Analysis Context
	final context = contextBuilder.createContext(
        contextRoot: contextRoots.first, byteStore: byteStore);
	

	//获取Analysis Driver
	final dartDriver = context.driver;

	//监听分析结果
	dartDriver.results.listen((analysisResult) {_processResult(...);});
	return dartDriver;
}

```

#### 2.感知代码变化
ServerPlugin提供contentChanged方法，我们只需要收到回调的时候将内容有改变的文件路径添加到AnalysisDriver即可
```Dart
@override
void contentChanged(String path) {
  super.driverForPath(path)?.addFile(path);
}

```

#### 3.利用AOP思想对AnalysisResult处理
Dart的抽象语法树遍历是通过访问者模式实现的，我们可以在我们想要处理的节点插入一个自定义的Visitor对其及其子节点实现访问。其中我们可以从AnalysisResult拿到编译单元(CompilationUnit)，每个编译单元就是一棵抽象语法树，我们可以通过其accept()方法插入一个Visitor。

#### 4.@FairPatch注解识别实现逻辑
我们了解到Dart抽象语法树是通过访问者模式实现的，就能够很简单地去实现自定义的逻辑了。我们要实现@FairPatch注解的识别，我们只需要在遍历Annotation节点时，判断一下annotation name是我们想要的FairPatch即可。示例代码如下：
```Dart
class _FairVisitor extends RecursiveAstVisitor<void> {

  @override
  void visitAnnotation(Annotation node) {
    node.visitChildren(this);
    if (node.name.name == \'FairPatch\') {
      //...
    }
  }
}
```

#### 5.if语法检测
因为if语法检测是需要前置条件的，首先得是用@FairPatch标注的类，其次还需要是在build()方法下的if才进行检测。

- 首先是build()方法检测，只需要在method deceleration的时候进行一下方法过滤即可。
```
@override
void visitMethodDeclaration(MethodDeclaration node) {
	if (node.name.name == \'build\') {
		//...
	}
}

```
- 其次是if语法检测，稍微复杂一点，if分为IfStatement和IfElement，IfStatement指代的是外层的if-else语句，IfElement指代的是嵌套在其他语法里的if-else语句，如果想要全覆盖if语法，则需要两者都实现。



![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/8d5d89cf-9d3d-4aa6-af5f-e6fbd89615f9image.png)
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/762805bc-488e-4cdb-91bb-e27157514abeimage.png)
上述两张图分别对应IfStatement和IfElement具体含义。

#### 6.Fair的Sugar.if语法糖分类实现
在Fair中常用的Sugar.if相关语法糖有Sugar.ifEqual、Sugar.ifEqualBool和Sugar.ifRange

- Sugar.ifRange
```Dart
static K ifRange<T, K>(
    T actual,
    List<T> expect, {
    required K trueValue,
    required K falseValue,
  }) =>
      expect.contains(actual) ? trueValue : falseValue;
```

- Sugar.ifEqual
```Dart
static K ifEqual<T, K>(
    T actual,
    T expect, {
    required K trueValue,
    required K falseValue,
  }) =>
      expect == actual ? trueValue : falseValue;
```

- Sugar.ifEqualBool
```Dart
static K ifEqualBool<T, K>(
    bool state, {
    required K trueValue,
    required K falseValue,
  }) =>
      state ? trueValue : falseValue;
```

使用Fair语法糖能够加快Fair的编译，所以我们都更推荐能使用语法糖就使用语法糖，我们要实现对语法糖分类，其实就是对if的condition进行区分，其中ifRange稍微复杂一点，则我们再讲下如何实现，其他也同理：
```Dart
//ifRange有个前置条件就是如参expect是一个List，所以再检测的时候只需要判断用户在调用list.contains(xx)即可

//先判断用户是在调用contains()方法
  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.name == \'contains\') {
      //...
    }
  }


//其次再判断调用contains方法的对象是List
  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);
     
    //判断staticType即可
    _result = node.target?.staticType?.isDartCoreList ?? false;
    if (_result) {
      _target = node.target;
      _actual = node.argumentList.arguments.first;
    }
  }
```

## 三、Fair Plugin实现效果展示
- Android Studio实现对build()方法下if语法块的检测效果
1. build方法下if的代码检测，及提示引导信息
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/44b58320-e608-420f-854f-799b5bf03cf5image.png)
2. 点击more action 或者 AS代码提示快捷键
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/41094a86-2aea-43e6-b7f0-69aef1c653c0image.png)
3. 根据提示点击替换
![image.png](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/fc73ed5f-9cf6-4c1b-9d52-42f41b3f7962image.png)


## 相关推荐
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
* [Flutter + Dart三端一体化动态化平台实践](https://juejin.cn/post/7137183955148603428)
* [超级全面的Flutter性能优化实践](https://juejin.cn/post/7145730792948252686)

## 支持我们
欢迎大家使用 Fair，也欢迎大家为我们点亮star  
<br>  

Github地址：[https://fair.58.com](https://fair.58.com)  
Fair官网：[https://fair.58.com](https://fair.58.com)  
<br>

## 欢迎贡献
通过[Issue](https://github.com/wuba/fair/issues)提交问题，贡献代码请提交Pull Request，管理员将对代码进行审核。

对Fair感兴趣的小伙伴，可以加入交流群。

| 微信                         | 
| ---------------------------- | 
| ![wechat](https://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/pic_Wc13Wc3759U7V913VaU5d35a35XUd359.png) |

> 微信入群：请先添加58技术小秘书为好友，备注fair，小秘书邀请进群。