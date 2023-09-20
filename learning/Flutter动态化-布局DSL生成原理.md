# 布局DSL生成原理

通过前文介绍，我们对布局动态化和逻辑动态化的实现采用了两套不同的实现方案，对于布局部分，我们在解析dart源文件之后生成DSL产物下发，然后在端上解析DSL构建布局的方式，逻辑动态化的部分，我们采用的是dart源码转js下发的方式。
整个动态化产物大致如下：
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0a6efb6206294897929c50103cf2a34e~tplv-k3u1fbpfcp-zoom-1.image)

本文主要介绍的正是DSL生成的整体流程。

关于JS部分产物生成逻辑，请参考接下来的连载《Fair下发产物--逻辑JS生成原理》。

文章的整体章节包括：

- 整体流程概述
- AST解析
- DSL生成
- 总结

## 1 整体流程概述

详述具体流程之前，我们先来看看整体的流程，然后再去讲解各个流程的原理细节。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/91b8052cabb8425d84cfe7eea6fa29d4~tplv-k3u1fbpfcp-zoom-1.image)

整个流程大致分为两部分：

1. 通过fair_ast_gen将源码解析并生成AstMap
2. 通过fair_dsl_gen将AstMap转换成我们需要的Fair DSL

这里涉及到两个概念，大家需要先了解一下：

- AST 全称是Abstract Syntax Tree，中文名为抽象语法树
- DSL 全称是Domain Specific Language，中文名为领域特定语言

这两个实际上都是与编程语言无关的概念，对这两个概念的理解比较重要，不过受限于篇幅，本文无法详细展开来解释，之前未接触过的建议先搜索做个大致的了解。

## 2 AST解析

### 2.1 源码解析

要把dart源码转换成我们需要的DSL，首先要对dart源码进行抽象语法分析，这里是整个转换过程的第一个关键点，甚至可以说是整个DSL生成的基础。好在dart
官方提供了解析工具包analyzer，这为我们整个的dsl生成工作大大减轻了工作量。
analyzer包的utilities类提供了parseFile函数，这个函数返回的CompilationUnit，实际上是一个编译单元，继承自AstNode，正是我们后面AST解析的入口。

### 2.2 AST解析

前面我们提到，AST是一种与编程语言无关的抽象语法树，对于这块的概念不是太熟同学，我们还是先看一个小例子。
比如下面这段代码：

``` dart
import 'package:flutter/material.dart';

class HelloWord extends StatelessWidget {
  const HelloWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildText(),
    );
  }

  _buildText() {
    return Text('Hello word');
  }
}


```

转换成AST的话，差不多是下面这样的：
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/973de45da4c54ba99bffab914c214328~tplv-k3u1fbpfcp-zoom-1.image)

实际转换产物很长，我们只截取一部分，不过可以大致看出AST的整个结构，可以看出，整个AST实际上是对源码的一个树状结构描述，整个结构里包含很多节点对象，每个节点下面又包含各种树形和子节点。
我们将100+的语法节点分类抽象为标识符、字面量、表达式、语法块，其它五大类，30+种的常用节点，同时剥离了与Fair产物解析无关的信息，只保留原始node中的关键信息，使得节点解析更加清晰。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1f2cee19ecc9406aa7df5e6421228885~tplv-k3u1fbpfcp-zoom-1.image)
节点类型很多，完整列表可以参考这里。
前面我们说到analyzer的praseFile方法解析完dart源文件后返回了AstNode实例，我们对AstNode的分析主要由该类的accept方法提供，这里用到了访问者设计模式。
accept方法接收的参数类型是AstVisitor，这是一个接口，我们正是通过这个接口的一系列方法实现对上述实例中各个节点的遍历的。
正如上面的例子看到的，原始AstNode数据量很大，哪怕是一个简单的Demo，解析出来的AST实际上是包含很多节点信息的，所以我们并不通过实现AstVisitor接口来实现所有节点类型的访问。analayzer包提供了SimpleAstVisitor，我们可以继承这个类来自定义Visitor，按需要选择我们支持的节点去实现方法就可以了。相关代码如下：

```dart
Future<Map> generateAstMap(String path) async {
  if (path.isEmpty) {
    stdout.writeln('File not found');
  } else {
    await _pathCheck(path);
    if (exitCode == 2) {
      try {
        var parseResult = parseFile(path: path, featureSet: FeatureSet.fromEnableFlags([]));
        var compilationUnit = parseResult.unit;
        //遍历AST
        var astData = compilationUnit.accept(CustomAstVisitor());
        return Future.value(astData);
      } catch (e) {
        stdout.writeln('Visit dart ast error: ${e.toString()}');
      }
    }
  }
  return Future.value();
}

```

最后返回的是一个Map类型的Ast节点树，感兴趣的同学可以直接通过源码了解细节。

## 3 DSL生成

### 3.1 从AST到DSL生成流程

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6cdb861d02d54904815353d42bc7a4b5~tplv-k3u1fbpfcp-zoom-1.image)
有了第一步生成的AST语法树Map产物，再根据AST Map来生成DSL就比较好理解了。在DSL的生成流程当中，主要是对节点的遍历,然后针对方法，表达式和变量的处理。
因为DSL主要处理的是布局动态化的部分，实际上对于一个Wiget的解析处理，我们主要是针对build方法中return的内容部分进行了提取并生成DSL（此处的methodMap，我们先放到后面再讲解，并不影响对主流程的理解）。相应代码如下所示：

```
    if (body?.isClassDeclaration==true) {
      var classBodyList = body!.asClassDeclaration.body;
      for (var bodyNode in classBodyList!) {
        //只处理build函数
        if (bodyNode?.isMethodDeclaration==true) {
          // if(bodyNode.isMethodDeclaration && bodyNode.asMethodDeclaration.name == 'build'){
          var buildBodyReturn = bodyNode?.asMethodDeclaration.body?.body;
          if (buildBodyReturn?.isNotEmpty==true &&
              buildBodyReturn?.last?.isReturnStatement==true &&
              buildBodyReturn?.last?.asReturnStatement.argument != null) {
            //解析build中widgetExpression
            if (bodyNode?.asMethodDeclaration.name == 'build') {
              tmpMap = _buildWidgetDsl(
                  buildBodyReturn?.last?.asReturnStatement.argument,
                  fairDslContex);
            } else if (buildBodyReturn?.last?.asReturnStatement.argument?.isMethodInvocation==true) {
              //混编逻辑处理
              var methodMap = {
                bodyNode?.asMethodDeclaration.name: _buildWidgetDsl(
                    buildBodyReturn?.last?.asReturnStatement.argument,
                    fairDslContex)
              };
              methods.addAll(methodMap);
            }
          }
        } else if (body.isFunctionDeclaration==true) {
          var functionDeclaration = body.asFunctionDeclaration;
          var buildBodyReturn = functionDeclaration.expression?.body?.body;
          var methodMap = {
            functionDeclaration.name: _buildWidgetDsl(
                buildBodyReturn?.last?.asReturnStatement.argument, fairDslContex)
          };
          // methodList.add(methodMap);
          methods.addAll(methodMap);
        }
      }
    }

```

对于DSL的格式，在debug环境，为了方便调试与直观的发现问题，我们的产物采用json格式，在线上环境，处于产物大小的控制及解析速度的考虑，我们下发产物格式改为flatbuffer(
google推出的一种高性能，小体积的序列化方案)。

### 3.2 fair布局动态化的大致原理

实际上有了analyzer作为基础，DSL的生成在技术上的难点并不大，可是我们的DSL的结构应该是什么样的，这取决于fair在运行时怎么对DSL进行还原，毕竟我们的DSL生成最后是为了动态还原成Wiget树并渲染的。针对这部分内容，我们做个大致的了解，这样能更好的理解下面的内容。
我们知道，Flutter因为某些原因，对dart:mirror包进行了移除，这就决定了我们没法通过反射对DSL进行布局构建还原，不过Flutter还有一个万能的方法Function.apply。

```dart
 /// void main() {
///   Function.apply(helloWorld, null);
/// }
/// // Output of the example is:
/// // Hello world!
/// ```
external static apply(Function function, List<dynamic>? positionalArguments,
    [Map<Symbol, dynamic>? namedArguments]);
```

这个方法，是我们动态化方案中的第二个重要方法，是Widget树还原的基础。
端上接收到下发的DSL后，只能解析到对应的字符串String类型，我们只需将对应的String映射到对应的方法(
此处主要支持构造方法和类静态方法)，便可以将对应的DSL还原并构建Widget树。在fair当中，大致是这样的。此处我们写了一个工具库，以方便对flutter
widget映射关系的自动生成。

```
'Align': (props) => Align(
            key: props['key'],
            alignment: props['alignment'] ?? Alignment.center,
            widthFactor: props['widthFactor']?.toDouble(),
            heightFactor: props['heightFactor']?.toDouble(),
            child: props['child'],
      ),
```

### 3.3 DSL结构

了解了fair对DSL解析执行的大致原理之后，我们再来理解DSL的大致结构就比较容易了。

```json
{
  "className": "AspectRatio",
  "na": {
    "paraName": {
      "className": "",
      "pa": [],
      "na": []
    }
  },
  "pa": [],
  "methodMap": {}
}
```

上面的className对应的是上面映射关系中的key，na和pa对应的是可选命名参数和位参数，此处我们需要解释的是上面提到的methodMap
所谓的methodMap，从字面意思上理解，其实就是方法缓存，在这里我们同样以上面的HelloWord类为例

```dart
import 'package:flutter/material.dart';

class HelloWord extends StatelessWidget {
  const HelloWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildText(),
    );
  }

  _buildText() {
    return Text('Hello word');
  }
}

```

可以看到，在我们的示例中build方法嵌套了一个布局构建方法_buildText()
。前面我们讲到，在布局动态化DSL生成过程中，我们主要是对build方法进行了提取，对于这种方法嵌套的布局构建代码，我们该怎么处理呢。大致的应对方法有几种：1.在框架层面做限制，不支持这种写法；2.解析时提取嵌套方法返回的Widget内容，在开发时支持方法嵌套，实际生成DSL时变成纯Widget嵌套方式；3.缓存嵌套的Widget构建方法，在运行时解析Json内容后对函数进行实时的替换。以上方式中，显然1是让人不可接受的，如果要接入动态化框架有这样的限制，恐怕会让使用的开发者望而却步。至于方法2和方法3，其实大同小异，一个是在解析时替换，一个是在运行时替换，考虑到我们生成DSL尽量不要改变原有的代码结构，我们选择了方案3。这就是为什么我们的DSL
Json中需要有methodMap的原因。

```json
{
  "className": "Center",
  "na": {
    "child": "%(_buildText)"
  },
  "methodMap": {
    "_buildText": {
      "className": "Text",
      "pa": [
        "Hello word"
      ]
    }
  }
}
```

以上面HelloWord类DSL解析结果为例，可以看到methodMap当中实际上缓存的是除build方法外的Widget构建的相关方法。

### 3.4 变量和表达式的处理

``` 
onPressed: _incrementCounter

```

这两种类型的变量引用，在AST中实际上对应的不同的类型，但是如果在DSL中我们还是简单的处理成了字符串，实际在DSL解析时就无法与普通字符串进行区分了，这里我们采取了一种比较简单的方式，在通过添加不同的特殊符号前缀进行了区分。
例如上面两个示例：

``` 
Text(\'$_counter\') => #($_counter)

onPressed: _incrementCounter => @(incrementCounter)

```

然后在Fair解析支持层面通过正则匹配到不同的表达式类型，来做变量的数据绑定已经方法的逻辑调用等。

### 4 总结

整个DSL生成流程细节很多，但是总结下来就是通过analyzert提供的AST解析工具提取并精炼对我们有用的信息，并且根据我们的Fair框架需要，组合成抽象化的布局DSL结构信息。

最后，我们借用Flutter动态化框架Fair的设计与思考中的关于DSL生成流程的一副图来总结一下详细的流程。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/257a64875bb449d49aa096adc21690b2~tplv-k3u1fbpfcp-zoom-1.image)

### Flutter动态化主题沙龙直播回放
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4170f3c6e30242f6bbad17442aabed6f~tplv-k3u1fbpfcp-zoom-1.image)

**Fair团队联手掘金平台于11月22日举办了《Flutter动态化—Fair 3.0全流程解决方案》主题沙龙**


沙龙主题：

- 第一章 FAIR 框架介绍
    + 出品人寄语
    + Fair介绍及实现原理揭秘
- 第二章 FAIR 原理介绍
    + Fair原理详解：布局动态化原理及优化
    + Fair原理详解：逻辑动态化原理及优化
- 第三章 FAIR 全流程工具介绍
    + Fair 3.0：Fair热更新平台搭建
    + Fair 3.0：Fair云开发平台&配套工具链


本次沙龙，干货满满，不仅可以协助大家快速搭建Flutter动态化工程，还深入剖析了Fair实现原理。欢迎大家回看~

[沙龙回放地址](https://juejin.cn/live/2209714)

### 支持我们

欢迎大家使用 Fair，也欢迎大家为我们点亮star  
Github地址：[https://github.com/wuba/fair](https://github.com/wuba/fair)  
Fair官网：[https://fair.58.com/](https://fair.58.com/)

### 欢迎贡献

通过[Issue](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fwuba%2Ffair%2Fissues)提交问题，贡献代码请提交Pull Request，管理员将对代码进行审核。
