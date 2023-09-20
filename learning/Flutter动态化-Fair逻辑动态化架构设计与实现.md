# 前言

Flutter 是 Google 开源的跨平台 UI 框架，其凭借“多端一致”和“渲染性能”上的优势成为越来越多开发者的首选。但随着使用规模加大，为了解决诸多快速迭代的业务产品线及需求，动态化成为了当下亟需解决的问题
Fair是58自研的的动态化框架，通过Fair Compiler工具对原生Dart源文件的自动转化，使项目获得动态更新Widget Tree和State的能力。

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fdbcc4cbd30c4a20b37b71d44a1c0b6a~tplv-k3u1fbpfcp-zoom-1.image)

下面是在Fair 3.0全流程解决方案上线前，对Fari原理进行一次全方位的梳理和总结。本文主要按照如下几个部分进行展开。

- 逻辑动态化架构设计与实现
- 逻辑动态化通信实现
- 下发产物-布局DSL生成原理
- 逻辑语法糖设计与实现

# Fair逻辑动态化架构设计与实现

Fair逻辑动态化，我们基本实现了跟数据相关的逻辑处理能力（这里的逻辑不只是逻辑运算，包括运算、分支、循环等逻辑处理能力）

下面我们就根据逻辑表达式出现的位置以及对不同数据类型的处理能力，做一下细致介绍。

## 1 这一部分的主要内容包括：

- 数据逻辑处理
- 布局中的逻辑处理
- Flutter类型数据处理

## 2 数据逻辑处理

**我们接触的每一个Flutter界面，大多由布局和逻辑相关的代码组成（我们重点考虑StatefulWidget的界面）。**  
如Flutter初始工程的Counting Demo：

```dart
class _MyHomePageState extends State<MyHomePage> {

  // 变量 
  int _counter = 0;

  // 方法
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // 外部参数
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', // 变量使用
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // 事件回调
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

如上，注释标记的就是页面中的数据以及数据处理逻辑部分。Fair的逻辑动态化是要实现这部分变量、方法等内容的脚本级动态解析以及DSL布局属性的绑定和后续用户操作事件方法的调用。

如何把Dart文件中的逻辑，变成可动态运行的变量和相关的操作呢？我们在项目初期也进行了若干方案的讨论与Demo开发尝试。例如直接下发Dart文件，在纯Dart侧完成布局和逻辑的解析与数据绑定，此操作类似于要开发一个Dart Script引擎，开发成本较高。我们最终确定：研发Dart2JS工具，把界面Dart文件的逻辑部分转换成JS脚本，然后利用原生的JSCore完成逻辑脚本的动态运行，由此我们最终的结构如下：

![原理结构图](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e876a615af8442118b6394d050e702df~tplv-k3u1fbpfcp-zoom-1.image)

我们实现了，把一个@FairPatch注解标注过的界面文件（Widget），通过Fair-Compiler工具编译后生成DSL布局文件和JS逻辑文件。为什么我们需要使用FairPatch注解，标注后生成？是因为我们整体的设计理念是Flutter原生界面和动态界面可以使用一个源文件来转换，动态化只是在紧急需求或者需求不确定的A/B测等临时场景使用，需求稳定之后，沉淀下来的源文件可以继续跟版使用，最大化的保持Flutter的性能。

Widget转换出的动态脚本，如下图所示。具体的原理请看“Fair下发产物–DSL生成原理与实现”和“Fair下发产物–Dart2JS生成原理与实现”。

![fair原理—compile](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f4a23e7aafed41c284889c2dbc17cdc2~tplv-k3u1fbpfcp-zoom-1.image)

在产物生成过程中，为了支持逻辑动态化，我们需要转译的原始Dart语法增加了很多。我拿Demo例子中的_counter变量举例，它是一个基础int类型。使用在如下代码中：

```
Text('$_counter')
```

虽然看起来是语句简短，但是在生成Text Widget时，数据绑定的阶段需要做细致的区分。如下是num转string再做参数传递的场景：

```json
{
  "className": "Text",
  "pa": [
    "#($_counter)"
  ]
}
```

逻辑动态化，最核心的难点就是如何处理变量。Flutter中的变量，可以是数据变量也可以是方法变量。根据Demo中的场景，我列举一下（我们根据数据绑定的需要，相同处理方式的变量表达式我们做了合并）：

**字符串强转基础变量**

```
Text('$_counter') => #($_counter)
```

**widget 传参变量**

```
Text(widget.title) => #(widget.title)
```

**方法变量（回调执行）**

```
onPressed: _incrementCounter => @(incrementCounter)
```

这些Flutter代码中的变量和逻辑方法，经过Fair
编译工具的转译变成了在DSL文件中的标识，变量和方法逻辑最终都会在JS引擎中具体实现。当然在从布局DSL生成对应界面的时候，需要我们实现数据绑定的模块。数据绑定过程就是根据上面提到的#()
、@()等不同表达式，完成Flutter 侧和 JS侧的变量处理需求，最终完成目标Widget的生成。

### 2.1 Dart和JS 双域变量映射

**Fair 框架设计：**
只从Dart侧去发起所需的变量值查询和对变量处理的方法调用，JS侧基本只作为数据值存储和数据逻辑相关的操作。

![Dart和JS 双域变量映射](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d4b553a886254e5facd55799b1024c06~tplv-k3u1fbpfcp-zoom-1.image)
Fair中的MVVM依赖于Flutter原生模式，如上图所示，JS域的数据同步给Dart域，只需要在JS侧调用熟悉的setState即可。当然这部分对使用Fair框架的开发者是无感知的，编译工具帮我们完成了相关的转换。原生代码和生成的JS代码，对比如下：

```
JS：
_incrementCounter: function _incrementCounter() {
    const __thiz__ = this;
    with (__thiz__) {
        setState('#FairKey#', function dummy() {
            _counter++;
        });
    }
},
```

```
Dart：
void _incrementCounter() {
  setState(() {
    _counter++;
  });
}
```

大家可以看到，除了JS简化访问域的with和通信目标对象需要的FairKey，其他代码差别并不大。具体的通信设计，可以关注下面的“逻辑动态化通信实现”部分。

### 2.2 生命周期

上面介绍了，双域的变量值如何映射。可能有同学就会问，Dart和JS的生命周期是怎么同步的呢？（Fair
提供的是StatefulWidget载体，所以此处只介绍StatefulWidget生命周期和JS生命周期的对应关系）

![什么周期](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9ad6652e6ade4f2d8d221f25a41d9ea9~tplv-k3u1fbpfcp-zoom-1.image)
如上图所示，Fair 提供给JS域2个感知的生命周期的回调。onLoad是在JS加载完成，通知JS侧进行变量初始化；onUnload是页面消失，通知JS侧进行资源回收。

### 2.3 最小渲染

Fair中对Widget属性的值变量都会生成对应的ValueNotifier对象，来实现局部的组件渲染。计算型变量，例如方法参数，我们不做特殊处理。参与Widget层级管理的变量，我们需要通过setState()
来完成Reload全布局。例如：

```
Sugar.ifEqualBool(_countCanMod2(),    // 控制Widgte布局的
	trueValue: Image.asset('assets/image/logo.png'),
	falseValue: Image.asset('assets/image/logo2.png')),
```

到这里我们可以整体回顾一下，Fair架构的工作流。如下图所示：

![工作流](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/36540efd6ec346b58415a973da21c6df~tplv-k3u1fbpfcp-zoom-1.image)

**上图所示的蓝色节点，说明如下：**

1. Dart 界面源文件通过Fair 编译工具转化成布局DSL和逻辑JS 文件
2. JS逻辑文件加载到JSCore，并完成JS域的初始化
3. DSL布局文件通过解析模块，生产对应的界面Widget
4. 在Widget的生成过程中，属性、事件等注册；值访问等需要依赖5的通信管道
5. 通过Flutter和JS模块的通信，实现JS域的值读取和方法处理

## 3 布局中的逻辑处理

上一节介绍了纯逻辑变量和相关方法的处理方法，但是面对逻辑和布局混编的场景我们怎么处理呢？

### 3.1  布局中的逻辑处理

Fair把在布局中常用的逻辑，进行了语法糖的封装。为什么采用语法糖的方式，主要是希望减少Fair
Compiler工具的转换成本。开发者也可以根据自己的需要进行扩展。举例如下：

```
condition == true ? widget1 : widget0
```

采用语法糖封装后（判断_count 是否为 2）：

```
Sugar.ifEqual(_count，2, 
		trueValue:Image.asset('assets/image/logo.png'),
		falseValue: Image.asset('assets/image/logo2.png')),

```

此外Fair布局中还支持ifRang、map、mapEach等语法糖。语法糖设计与实现，详见“Fair 逻辑语法糖设计与实现”。

### 3.2 布局中的子方法处理

在项目中，build内的布局代码往往会非常多，大部分开发者都会拆分成小的布局子方法。例如：

```
// 定义布局子方法
Widget _titleWidget() {
  return Text(getTitle());
}

// 组合布局
...
appBar: AppBar(
  title: _titleWidget(),
)
...
```

我们把这些布局调用关系，放在DSL中转化，通过Widget构建时动态调用，具体的转化DSL JSON结构如下：

```
{
  "className": "Scaffold",
  "na": {
    "appBar": {
      "className": "AppBar",
      "na": {
        "title": "%(_titleWidget)"
      }
    },
    "body": {...},
  },
  "methodMap": {
    "createState": "%(_State)",
    "_titleWidget": {
      "className": "Text",
      "pa": [
        "%(getTitle)"
      ]
    }
  }
}
```

通过子布局方法在methodMap注册，在构建时完成整体拼装，来满足开发者对布局拆封的需求。到这里大家也会发现，Fair的设计是尽可能的把逻辑处理在Dart侧实现，减少Flutter和JS的通信次数，提高整体动态的性能。

## 4 Flutter类型变量的处理

到这里同学们应该会想，Fair把Flutter里面的数据类型，在JS侧都实现了一遍吗？答案是否定的，JS侧虽然我们准备了一些Dart基础类和JS基础类的对应类型，但是并没有完全覆盖。当开发者遇到Flutter内置类型，比如像ScrollController，我们怎么处理呢？  
Fair提供了原生模版加界面动态的模式，提供给开发者扩展。我们用加载更多列表Demo 举例，原生模版如下：

```
class ListDelegate extends FairDelegate {
  ScrollController _scrollController;

  @override
  Map<String, Function> bindFunction() {
    var functions = super.bindFunction();
    functions.addAll({
      '_itemBuilder': _itemBuilder,
      '_onRefresh': _onRefresh,
    });
    return functions;
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var pros = super.bindValue();

    pros.addAll({
      '_scrollController': () => _scrollController,
    });
    return pros;
  }

  @override
  void initState() {
    // 监听滑动
    _scrollController = ScrollController()
      ..addListener(() {
        //判断是否滑到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _onLoadMore();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onLoadMore() {
    runtime?.invokeMethod(pageName, '_onLoadMore', null);
  }

  Future<void> _onRefresh() async {
    await runtime?.invokeMethod(pageName, '_onRefresh', null);
  }
  
  // 构建item动态界面
  Widget _itemBuilder(context, index) {
    var result = runtime?.invokeMethodSync(pageName, '_onItemByIndex', [index]);
    var value = jsonDecode(result);
    var itemData = value['result'];
    return FairWidget(
      name: itemData['name'],
      path: itemData['path'],
      data: {'fairProps': jsonEncode({'item': itemData['props']})},
    );
  }
}
```

这样设计的好处，有像_scrollController.position监听不停的位置变化时，如果这个过程设计成Flutter不停的往JS侧发送位置偏移值，由JS侧实现阀值判断的话，对bridge的压力会非常大。

通过原生模版，再配合模版中使用的JS通信协议，可以完全自定义JS侧的逻辑，此例的对应的JS如下：

``` 
GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;
    return {
        list: List(), 
        _scrollController: null, 
        listIsEmpty: function listIsEmpty() {
            const __thiz__ = this;
            with (__thiz__) {
                return list == null || list.isEmpty;
            }
        }, _onLoadMore: async function onLoadMore() {
            // 上拉加载更多处理
        }, _onRefresh: async function _onRefresh() {
            // 下拉加载更多处理
        }, onLoad: function onLoad() {
            // 界面逻辑数据初始化
        }, onUnload: function onUnload() {
            // 界面逻辑数据释放
        }, _itemCount: function _itemCount() {
            // 下拉加载更多处理
        }, _onItemByIndex: function _onItemByIndex(index) {
            // 获取单个列表卡片数据
            const __thiz__ = this;
            with (__thiz__) {
                return list[index];
            }
        }
    };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
```

如上代码中的onItemByIndex、onRefresh、onLoadMore等方法名，只需要跟Dart侧的Delegate模版调用 一一对应起来就好。在模版中完成支持用户的自定义行为。


### Flutter动态化主题沙龙倒计时，敬请参加！！！
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/47bce145ba72448a977b17ff6455ff78~tplv-k3u1fbpfcp-zoom-1.image)

**Fair团队将联手掘金平台于11月22日 18:00举办《Flutter动态化—Fair 3.0全流程解决方案》主题沙龙**


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


本次沙龙，干货满满，不仅可以协助大家快速搭建Flutter动态化工程，还会深入剖析实现原理。Fair团队带着满满诚意，静候各位开发者们批评指正~！


预约&参与方式：

- 通过官网添加小秘书加入社群
- 关注掘金官网近期通告

### 支持我们

欢迎大家使用 Fair，也欢迎大家为我们点亮star  
Github地址：[https://github.com/wuba/fair](https://github.com/wuba/fair)  
Fair官网：[https://fair.58.com/](https://fair.58.com/)

### 欢迎贡献

通过[Issue](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fwuba%2Ffair%2Fissues)提交问题，贡献代码请提交Pull Request，管理员将对代码进行审核。