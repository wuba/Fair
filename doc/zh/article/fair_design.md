# Flutter动态化框架Fair的设计与思考

![fair logo](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/690a8716eb184cd5aa11c2beb8d8d436~tplv-k3u1fbpfcp-zoom-1.image)

> 同步发表于掘金[《Flutter动态化框架Fair的设计与思考》](https://juejin.cn/post/6896655572910014478)

**作者**：58同城，平台技术部-吴朝彬，本地服务-李旭

## 动态化解决什么问题

这是一个“送分题”😅。在很多技术框架中，都有动态化的诉求，拿到Flutter中，同样如此。在笔者看来，进行Flutter的动态化探索是为了一件事情：

> 补全Flutter动态能力短板，增强业务落地动力

我们都知道，当做一件事情方法是唯一的话反而是简单些，因为没得选。但是如果有多种可选方案。那么势必就存在技术选型的问题。
> 如果要起一个新项目，你是考虑React技术栈呢，还是Flutter技术栈？

当然本文不是来“讨论”这个的，读者可以自己去考虑。在业内，关于Flutter的动态化，已经有不少先行者了。下面是我们在调研期间，收集到的一些动态化实践文章：

| 思路 | 地址 |
| :----------------- | :----------------------------------------------------------- |
| 布局动态 | [https://www.yuque.com/xytech/flutter/emdguh](https://www.yuque.com/xytech/flutter/emdguh) |
| 布局动态 | [https://www.yuque.com/xytech/flutter/zggn7u](https://www.yuque.com/xytech/flutter/zggn7u) |
| 逻辑动态 | [https://tech.meituan.com/2020/06/23/meituan-flutter-flap.html](https://tech.meituan.com/2020/06/23/meituan-flutter-flap.html) |
| JS逻辑动态 | [https://github.com/mxflutter/mxflutter](https://github.com/mxflutter/mxflutter) |
| JS逻辑动态 | [https://github.com/githubliruiyuan/HybridFlutter](https://github.com/githubliruiyuan/HybridFlutter) |
| JS逻辑动态| [https://github.com/Newcore-mobile/DynamicFlutter](https://github.com/Newcore-mobile/DynamicFlutter) |


当然还有其他的一些文章，这里不一一举例，在Flutter实践层面，简单来说分为三个流派：
* 方案一：JavaScript是最好的语言（🤣碰瓷PHP）

主要思路：利用Flutter做渲染，开发使用js，逻辑层通过v8/jscore解释运行。代表框架是MXFlutter。这个框架是开源的，大写的👍。

* 方案二：DSL，颤抖吧布局

主要思路：基于模板实现动态化，主要针对布局层，逻辑层不能直接动态，需要封装为逻辑组件。这个没有关注到知名的开源项目。

* 方案三：布局，逻辑，一把梭

主要思路：与方案一的最主要区别是，逻辑层也是使用dart，增加了一层语法解析和运行时。有一个代表，美团团的Flap，然而没有开源动向，无从考察更多。

> 这里没有提二进制整体替换的思路，原因是笔者认为它更接近与Native的插件化，在实现层面和Flutter的关联不大，并且基于二进制产物的拆分与动态下发是可以与上述方案结合使用的，并不是二选一的问题。

读到这儿，不知道你有没有一个胆大想法？
> Flutter动态化轮子这么缺，都是思路为主，是不是可以搞一个出来？

## 原型构思

> 曰：欲善其事，必先利器。

光有大胆的想法是不够的。我们在项目启动初期，花了不少时间，去学习，去验证可行性。这个阶段我把它定义为：`Prototype 0.0`。以兴趣为导向，在招募的flutter成员中，挑选了些“壮士”去了解动态化的技术，实践证明，这是一个还凑活的法子。

在这个原型孵化的阶段，第一要务是`解决能不能的问题`。粗粒度的划出几个点，逐一攻破，任务点比较多，这里例举一二：

* DSL Definition =》实现从Dart到DSL的转义规则，JSON/FlatBuffers (手动=》自动)
* DSL Adapter =》实现DSL产物到Flutter Widget的转换

作为一枚开发，快速学习的方法与很多，最重要的是源码学习。
> Talk is cheap，show me the code。

这是Linus Torvalds说的，过了多少年都还是这么真实。在完成资料学习和源码研究过程中慢慢体会精髓，找到突破口。这里的源码大部分指的是analyer这个package。

在原型开发过程中，做要的是很明确，不那么明确的是方法，比如我们上来就可以想到做一个原型的几个关键点：

- 定义的一段json，实现从json渲染为widget
- 进一步：将flutter demo转义为json，并再次渲染为flutter app
- 难点一：事件如何处理？
- 难点二：动画如何事件处理？

完成原型后，大概做出了一点点丑陋的模样。这是部分demo页面，做的一个ListView文本列表。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c4bbf0ef535b4e9094d4ba245b0d3338~tplv-k3u1fbpfcp-zoom-1.image)

## Fair - Flutter over the air
完成了原型调研，和基本技术点的分析后，我们整了一个更大的目标，算是正式向SDK迈进了。我们为动态化框架命名为`Fair`，取自: Flutter over the air。

### 确定I/O问题
既然是解决动态化问题，设计的导向自然是怎么确定输入与输出？
![fair输入输出.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/43da492add754f5bbaf7ad7c749f8fcb~tplv-k3u1fbpfcp-zoom-1.image)

站在开发者的角度，我们希望开发者尽量少的感知开发的变化，Fair的使用要在细节上尽量透明。这就要求我们提供一个中间件（编译器）实现这个“透明动作”。

站在Flutter的角度，我们需要正确的识别一致约定格式化产物。这就要求我们提供一个DartVM下能够运转的解析器（运行时）实现对产物的“运行”。

站在App的角度，我们需要管理产物，比如加载，持久化，版本控制等。这就要求我们提供搭建一套后端的产物的管理系统和移动端的加载体系。

根据不同视角下的I/O关系，我们可以粗粒度的规划出几个模块
- Fair Plugin 负责加载，解析，最后以flutter的形式去展现bundle
- Fair Binding tool 辅助构建工具，提供自动化的转换能力
- Fair Manager Server 简单的资源管理服务
- Fair Manager API Android/iOS侧与配合使用的服务

![fair draft](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2545b66497854516a765ffc2e9eeff7c~tplv-k3u1fbpfcp-zoom-1.image)

### Fair SDK上手
在继续介绍Fair的技术细节前，我们看下怎么去使用这个SDK。推荐的接入姿势如下，将App包裹一层FairApp组件，就可以在所有子节点下愉快的玩耍了：
![use fair](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fda45fcb58d543e98b9d78ea0af49edb~tplv-k3u1fbpfcp-zoom-1.image)

在FairApp中，每一个动态化的页面都是一个FairWidget，可以通过入参来提供“产物”。
```dart
FairWidget(
  path: 'assets/bundle/lib_page_dynamic_widget.fair.bin',
  data: {'content': 'Red Box'},
)
```
这个bin是哪里来的？bin是一个Fair能够识别的产物，可以理解为一个Bundle。可以手工编写，也可以通过Fair去自动生成。要将一个现成的Flutter页面转成bundle，需要添加一下注解：

* 将目标页面添加@FairPatch注解
* 为数据对象添加@FairWell注解

![fair annotation](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cf553ad3bc4c4d41a380fcca4bc7729f~tplv-k3u1fbpfcp-zoom-1.image)

目前，不是所有的Flutter Widget都可以无痛一键转换。Fair默认支持布局类的转换，这要求build中不含有逻辑运算。如果有逻辑，需要手工去封装或者提供代理的绑定对象。

## Fair架构
从Prototype演化而来的Fair，很多对外的api在开发早期发生了多次变化，直到后期慢慢收敛稳定下来。在编码过程中，随着需要考虑最终的效果，也就是SDK化，不能像原型中的随意，我们一直在收敛入参，提供可读性。

最终框架可以用一张通俗的结构图来呈现，除去前后端server，整体包含三块：

![fair compoents](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9c3effd53f7e43b79f6745f98c3ee0a5~tplv-k3u1fbpfcp-zoom-1.image)

在“运行时”这一块，主要包括了bundle资源的加载器，解析器以及组件代理层。“编译器”这一块，并不是平时说的三段式或者两段式的编译器。Fair Compiler的是一个基于Flutter的build runner机制下的编译工具，主要用于将dart代码生成binding和bundle。

### 版本适配
开发Flutter的小伙伴都知道，Flutter版本迭代非常快，因此如何做好版本兼容是值得思考的一件事情。

在58同样如此，有的业务团队可能开发早，使用的是较为“老的版本”比如1.17.x，截止本文撰写（2020.11.03），flutter稳定版已经发布到了1.22.x。虽然Fair的api几乎没有使用版本特定的API，但是为了实现动态组件，我们必须要提前生成组件映射表，这个映射表就是与flutter版本完全耦合的产物。

我们开发的时候flutter是1.20.x，因此我们默认生成额这个版本的flutter组件。为了适配多版本，我们将这与flutter版本耦合的逻辑，提取为了fair_version库，通过生成不同版本来支持接入侧的诉求。一旦flutter发布新的稳定版本，我们可以快速生成新的对应的fair_version。

```yaml
# Switch to another stable flutter version
dependency_overrides:
  fair_version:
    git:
      url: https://github.com/wuba/fair.git
      ref: main
      path: fair_version/flutter_1_12_13
```
### 组件生成
通过编写组件映射表，Fair可以支持更多的Widget，既可以是Flutter框架的，也可以是三方组件。

比如我们自定义了一个CustomTag组件，需要生成绑定映射组件，同时我们还想额外为convex_bottom_bar这个社区的package组件生成映射组件。可以这么做：
![fair binding](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6a0e7d5d380d49a9833cbdc6318ea806~tplv-k3u1fbpfcp-zoom-1.image)

生成的代码片段如下：
![3rd widget](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a484bbdab0384ead89a00bde533d9b38~tplv-k3u1fbpfcp-zoom-1.image)

### Bundle生成
为了实现无缝无缝接入，我们目标是支持从flutter布局直接生成业务bundle，供后端下发使用。
利用build_runner机制，我们可以很好地将bundle构建与flutter工程结合起来。理想情况下，开发者所要做的就是，就是添加注解，然后有flutter编译工具为你生成产物。
![build_runner](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ae04a5b9506e42eca6483ae7f6371a43~tplv-k3u1fbpfcp-zoom-1.image)

## DSL与AST
相信能阅读到这里的小伙伴，都是对动态化真的感兴趣。这两个名词非常常见，都是和语言无关的一种通用概念：
* DSL 全称是Domain Specific Language
* AST 全称是Abstract Syntax Tree

在动态化中，DSL是我们的中间产物的表达形式，而AST是我们用来分析的原产物表达形式。

在Fair Comiplier中，我们设计了一层fairc，他是辅助编译工具中的重要组成部分，基于AST提供了DSL生成能力，帮助开发者快速将源码生成DSL Bundle文件和Proxy文件。下面简单介绍一下在Fair中的实际用处。

![dsl](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a236eb2dc1b74025b35658e9bfa1d3fd~tplv-k3u1fbpfcp-zoom-1.image)

DSL的生成思路如上图，就是将源代码通过fair_ast_get生成CustomAST,然后将CustomAST通过fair_dsl_gen 生成目标Fair DSL。下面看一下转换器的整体工作流程。

![dsl flow ](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6faf9a0951b04fb0afb0ec71a3751f3d~tplv-k3u1fbpfcp-zoom-1.image)

首先我们将100+的语法节点分类抽象为标识符、字面量、表达式、语法块，其它五大类，30+种的常用节点，同时剥离了与业务解析无关的信息，只保留原始node中的关键信息。使得节点解析更加清晰。

| 标识符             | 字面量          | 表达式           | 语法块          | 其它    |
| ------------------ | --------------- | ---------------- | --------------- | ------- |
| Identifier         | NumericLiteral  | NamedExpression  | ReturnStatement | Program |
| PrefixedIdentifier | StringLiteral   | MemberExpression | IfStatement     |         |
|                    | MapLiteralEntry | MethodInvocation | ForStatement    |         |
|                    | ......          | ......           | ......          |         |

原始语法树的数据量很大，同时vistor模式不方便我们结合上下文来处理业务，所以我们要精简，构造自己的语法树，方便我们的后续处理。

其次analyzer 提供的访问者模式（visitor）模式是一种离散型方法处理，递归处理会使得业务逻辑散落到各处，使得业务逻辑复杂不易维护。于是通过DSL的特殊业务形态进行抽象，变成了 WidgetDsl和ValueExpression两种集约递归节点，使得解析变得更加清晰。

## Next
Fair框架作为Magpie项目的二期产物，完成了他的阶段使命，从无到有，实现一套模板动态框架，后续结合业务实际情况和反馈，将继续迭代，提供更多的动态能力。例如对模板语法的更好兼容等，对逻辑动态化的持续跟进。



---
感谢UXD的Kaibin老师提供设计支持