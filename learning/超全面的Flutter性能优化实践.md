## 前言
Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的，可以用一套代码同时构建Android和iOS应用，性能可以达到原生应用一样的性能。但是，在较为复杂的 App 中，使用 Flutter 开发也很难避免产生各种各样的性能问题。在这篇文章中，我将介绍一些 Flutter 性能优化方面的应用实践。

## 一、优化检测工具

### flutter编译模式

Flutter支持Release、Profile、Debug编译模式。

1. Release模式,使用AOT预编译模式，预编译为机器码，通过编译生成对应架构的代码，在用户设备上直接运行对应的机器码，运行速度快，执行性能好；此模式关闭了所有调试工具，只支持真机。

2. Profile模式，和Release模式类似，使用AOT预编译模式，此模式最重要的作用是可以用DevTools来检测应用的性能，做性能调试分析。

3. Debug模式，使用JIT（Just in time）即时编译技术，支持常用的开发调试功能hot reload，在开发调试时使用，包括支持的调试信息、服务扩展、Observatory、DevTools等调试工具，支持模拟器和真机。

通过以上介绍我们可以知道,flutter为我们提供 profile模式启动应用,进行性能分析,profile模式在Release模式的基础之上，为分析工具提供了少量必要的应用追踪信息。

### 如何开启profile模式？
如果是独立flutter工程可以使用flutter run --profile启动。如果是混合 Flutter 应用，在 flutter/packages/flutter_tools/gradle/flutter.gradle 的 buildModeFor 方法中将 debug 模式改为 profile即可。


### 检测工具

#### 1、Flutter Inspector (debug模式下)

Flutter Inspector有很多功能，其中有两个功能更值得我们去关注，例如：“Select Widget Mode” 和 “Highlight Repaints”。

Select Widget Mode点击 “Select Widget Mode” 图标，可以在手机上查看当前页面的布局框架与容器类型。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f6a0d3c005684c238a090c627308de90~tplv-k3u1fbpfcp-zoom-1.image)

通过“Select Widget Mode”我们可以快速查看陌生页面的布局实现方式。

![1662522497922.jpg](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/648b43862e634d2186ab566beb72dc69~tplv-k3u1fbpfcp-zoom-1.image)

Select Widget Mode模式下,也可以在app里点击相应的布局控件查看

#### Highlight Repaints

点击 “Highlight Repaints” 图标，它会 为所有 RenderBox 绘制一层外框，并在它们重绘时会改变颜色。
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7284e01aa3934b6282b377ce77cb0bd0~tplv-k3u1fbpfcp-zoom-1.image)

这样做帮你找到 App 中频繁重绘导致性能消耗过大的部分。

例如：一个小动画可能会导致整个页面重绘，这个时候使用 RepaintBoundary Widget 包裹它，可以将重绘范围缩小至本身所占用的区域，这样就可以减少绘制消耗。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e7e4df64f9f74a0a926c2cb46c06b90a~tplv-k3u1fbpfcp-zoom-1.image)


#### 2、Performance Overlay(性能图层)

在完成了应用启动之后，接下来我们就可以利用 Flutter 提供的渲染问题分析工具，即性能图层（Performance Overlay），来分析渲染问题了。

我们可以通过以下方式开启性能图层
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cf18e959538c4741b3479d1605f9d086~tplv-k3u1fbpfcp-zoom-1.image)

性能图层会在当前应用的最上层，以 Flutter 引擎自绘的方式展示 GPU 与 UI 线程的执行图表，而其中每一张图表都代表当前线程最近 300 帧的表现，如果 UI 产生了卡顿，这些图表可以帮助我们分析并找到原因。
下图演示了性能图层的展现样式。其中，GPU 线程的性能情况在上面，UI 线程的情况显示在下面，蓝色垂直的线条表示已执行的正常帧，绿色的线条代表的是当前帧：

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/286a7683b36944e08e75d347cf0d6228~tplv-k3u1fbpfcp-zoom-1.image)

如果有一帧处理时间过长，就会导致界面卡顿，图表中就会展示出一个红色竖条。下图演示了应用出现渲染和绘制耗时的情况下，性能图层的展示样式：

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/67cdd48f995245e48a759d561cf06dcd~tplv-k3u1fbpfcp-zoom-1.image)

如果红色竖条出现在 GPU 线程图表，意味着渲染的图形太复杂，导致无法快速渲染；而如果是出现在了 UI 线程图表，则表示 Dart 代码消耗了大量资源，需要优化代码执行时间。

#### 3、CPU Profiler(UI 线程问题定位)

在视图构建时，在 build 方法中使用了一些复杂的运算，或是在主 Isolate 中进行了同步的 I/O 操作。
我们可以使用 CPU Profiler 进行检测:

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/02d5542f493f4860bb675b4c39a08d06~tplv-k3u1fbpfcp-zoom-1.image)

你需要手动点击 “Record” 按钮去主动触发，在完成信息的抽样采集后，点击 “Stop” 按钮结束录制。这时，你就可以得到在这期间应用的执行情况了。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2d913610d9d94d3d8da0b24b2a93fc30~tplv-k3u1fbpfcp-zoom-1.image)

其中：

**x 轴**：表示单位时间，一个函数在 x 轴占据的宽度越宽，就表示它被采样到的次数越多，即执行时间越长。

**y 轴**：表示调用栈，其每一层都是一个函数。调用栈越深，火焰就越高，底部就是正在执行的函数，上方都是它的父函数。

**通过上述CPU帧图我们可以大概分析出哪些方法存在耗时操作,针对性的进行优化**

一般的耗时问题，我们通常可以 使用 Isolate（或 compute）将这些耗时的操作挪到并发主 Isolate 之外去完成。

**例如:复杂JSON解析子线程化**

Flutter的isolate默认是单线程模型，而所有的UI操作又都是在UI线程进行的，想应用多线程的并发优势需新开isolate 或compute。无论如何await，scheduleTask 都只是延后任务的调用时机，仍然会占用“UI线程”， 所以在大Json解析或大量的channel调用时，一定要观测对UI线程的消耗情况。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a2fd7a1f55c149df87bf0f46e6b9e676~tplv-k3u1fbpfcp-zoom-1.image)


## 二、Flutter布局优化

Flutter 使用了声明式的 UI 编写方式，而不是 Android 和 iOS 中的命令式编写方式。

1. 声明式:简单的说，你只需要告诉计算机，你要得到什么样的结果，计算机则会完成你想要的结果，声明式更注重结果。

2. 命令式:用详细的命令机器怎么去处理一件事情以达到你想要的结果，命令式更注重执行过程。

**flutter声明式的布局方式通过三棵树去构建布局,如图:**

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/44757c4bb36644d8bf37190e5c1a4e49~tplv-k3u1fbpfcp-zoom-1.image)

- **Widget Tree：** 控件的配置信息，不涉及渲染，更新代价极低。

- **Element Tree ：** Widget树和RenderObject树之间的粘合剂,负责将Widget树的变更以最低的代价映射到RenderObject树上。

- **RenderObject Tree ：** 真正的UI渲染树，负责渲染UI，更新代价极大。

#### 1、常规优化
常规优化即针对 build() 进行优化，build() 方法中的性能问题一般有两种：耗时操作和 Widget 层叠。

**1）、在 build() 方法中执行了耗时操作**

我们应该尽量避免在 build() 中执行耗时操作，因为 build() 会被频繁地调用，尤其是当 Widget 重建的时候。
此外，我们不要在代码中进行阻塞式操作，可以将一般耗时操作等通过 Future 来转换成异步方式来完成。
对于 CPU 计算频繁的操作，例如图片压缩，可以使用 isolate 来充分利用多核心 CPU。


**2）、build() 方法中堆叠了大量的 Widget**

这将会导致三个问题：

1、代码可读性差：画界面时需要一个 Widget 嵌套一个 Widget，但如果 Widget 嵌套太深，就会导致代码的可读性变差，也不利于后期的维护和扩展。

2、复用难：由于所有的代码都在一个 build()，会导致无法将公共的 UI 代码复用到其它的页面或模块。

3、影响性能：我们在 State 上调用 setState() 时，所有 build() 中的 Widget 都将被重建，因此 build() 中返回的 Widget 树越大，那么需要重建的 Widget 就越多，也就会对性能越不利。

所以，你需要 控制 build 方法耗时，将 Widget 拆小，避免直接返回一个巨大的 Widget，这样 Widget 会享有更细粒度的重建和复用。

**3）、尽可能地使用 const 构造器**

当构建你自己的 Widget 或者使用 Flutter 的 Widget 时，这将会帮助 Flutter 仅仅去 rebuild 那些应当被更新的 Widget。
因此，你应该尽量多用 const 组件，这样即使父组件更新了，子组件也不会重新进行 rebuild 操作。特别是针对一些长期不修改的组件，例如通用报错组件和通用 loading 组件等。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e22546a75aa44d228778402aed067227~tplv-k3u1fbpfcp-zoom-1.image)


**4）、列表优化**

- **尽量避免使用 ListView默认构造方法**

  不管列表内容是否可见，会导致列表中所有的数据都会被一次性绘制出来

- **建议使用 ListView 和 GridView 的 builder 方法**

  它们只会绘制可见的列表内容，类似于 Android 的 RecyclerView。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3251d2cc7e814dca998abc673565984b~tplv-k3u1fbpfcp-zoom-1.image)

其实，本质上，就是对列表采用了懒加载而不是直接一次性创建所有的子 Widget，这样视图的初始化时间就减少了。

#### 2、深入光栅化优化

**优化光栅线程**

屏幕显示器一般以60Hz的固定频率刷新，每一帧图像绘制完成后，会继续绘制下一帧，这时显示器就会发出一个Vsync信号，按60Hz计算，屏幕每秒会发出60次这样的信号。CPU计算好显示内容提交给GPU，GPU渲染好传递给显示器显示。
Flutter遵循了这种模式，渲染流程如图：

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4dd04f149c3f4dc6acf89c6426a225c0~tplv-k3u1fbpfcp-zoom-1.image)

flutter通过native获取屏幕刷新信号通过engine层传递给flutter framework
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/49f200fb4347480ab1a89f459f671bfd~tplv-k3u1fbpfcp-zoom-1.image)

**所有的 Flutter 应用至少都会运行在两个并行的线程上：UI 线程和 Raster 线程。**

- **UI 线程**

  构建 Widgets 和运行应用逻辑的地方。


- **Raster 线程**

  用来光栅化应用。它从 UI 线程获取指令将其转换成为GPU命令并发送到GPU。

**我们通常可以使用Flutter DevTools-Performance 进行检测，步骤如下：**

- 在 Performance Overlay 中，查看光栅线程和 UI 线程哪个负载过重。

- 在 Timeline Events 中，找到那些耗费时间最长的事件，例如常见的 SkCanvas::Flush，它负责解决所有待处理的 GPU 操作。

- 找到对应的代码区域，通过删除 Widgets 或方法的方式来看对性能的影响。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5637a4be5b5b4700b64845b408182ef2~tplv-k3u1fbpfcp-zoom-1.image)


## 三、Flutter内存优化

**1、const 实例化**

const 对象只会创建一个编译时的常量值。在代码被加载进 Dart Vm 时，在编译时会存储在一个特殊的查询表里，仅仅只分配一次内存给当前实例。

我们可以使用 **flutter_lints** 库对我们的代码进行检测提示

**2、检测消耗多余内存的图片**

Flutter Inspector：点击 “Highlight Oversizeded Images”，它会识别出那些解码大小超过展示大小的图片，并且系统会将其倒置，这些你就能更容易在 App 页面中找到它。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ab8453559754416da641191ddd7d26e2~tplv-k3u1fbpfcp-zoom-1.image)

通过下面两张图可以清晰的看出使用“Highlight Oversizeded Images”的检测效果
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/52a504dee31e422485caff0eb5a77d22~tplv-k3u1fbpfcp-zoom-1.image)
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/565713e57f224b13879bdc2bb9fc38bc~tplv-k3u1fbpfcp-zoom-1.image)

针对这些图片，你可以指定 cacheWidth 和 cacheHeight 为展示大小，这样可以让 flutter 引擎以指定大小解析图片，减少内存消耗。
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/02f968e7f1a2482e9e496c3086b365b8~tplv-k3u1fbpfcp-zoom-1.image)

**3、针对 ListView item 中有 image 的情况来优化内存**

ListView 不会销毁那些在屏幕可视范围之外的那些 item，如果 item 使用了高分辨率的图片，那么它将会消耗非常多的内存。

ListView 在默认情况下会在整个滑动/不滑动的过程中让子 Widget 保持活动状态，这一点是通过 AutomaticKeepAlive 来保证，在默认情况下，每个子 Widget 都会被这个 Widget 包裹，以使被包裹的子 Widget 保持活跃。
其次，如果用户向后滚动，则不会再次重新绘制子 Widget，这一点是通过 RepaintBoundaries 来保证，在默认情况下，每个子 Widget 都会被这个 Widget 包裹，它会让被包裹的子 Widget 仅仅绘制一次，以此获得更高的性能。
但，这样的问题在于，如果加载大量的图片，则会消耗大量的内存，最终可能使 App 崩溃。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/83af938c17024734a9815e7146d95163~tplv-k3u1fbpfcp-zoom-1.image)

通过将这两个选项置为 false 来禁用它们，这样不可见的子元素就会被自动处理和 GC。

**4、多变图层与不变图层分离**

在日常开发中，会经常遇到页面中大部分元素不变，某个元素实时变化。如Gif，动画。这时我们就需要RepaintBoundary，不过独立图层合成也是有消耗，这块需实测把握。

这会导致页面同一图层重新Paint。此时可以用RepaintBoundary包裹该多变的Gif组件，让其处在单独的图层，待最终再一块图层合成上屏。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fa3555db35944fe8a29aac6a61926505~tplv-k3u1fbpfcp-zoom-1.image)

**5、降级CustomScrollView,ListView等预渲染区域为合理值**

默认情况下，CustomScrollView除了渲染屏幕内的内容，还会渲染上下各250区域的组件内容，例如当前屏幕可显示4个组件，实际仍有上下共4个组件在显示状态，如果setState()，则会进行8个组件重绘。实际用户只看到4个，其实应该也只需渲染4个， 且上下滑动也会触发屏幕外的Widget创建销毁，造成滚动卡顿。高性能的手机可预渲染，在低端机降级该区域距离为0或较小值。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0b3dee2fbb024e8e9c8eb68629547e55~tplv-k3u1fbpfcp-zoom-1.image)


## 四、总结

**Flutter为什么会卡顿、帧率低？总的来说均为以下2个原因：**

- UI线程慢了-->渲染指令出的慢


- GPU线程慢了-->光栅化慢、图层合成慢、像素上屏慢

所以我们一般使用flutter布局尽量按照以下原则

**Flutter优化基本原则:**

- 尽量不要为 Widget 设置半透明效果，而是考虑用图片的形式代替，这样被遮挡的 Widget 部分区域就不需要绘制了；

- 控制 build 方法耗时，将 Widget 拆小，避免直接返回一个巨大的 Widget，这样 Widget 会享有更细粒度的重建和复用；

- 对列表采用懒加载而不是直接一次性创建所有的子 Widget，这样视图的初始化时间就减少了。


## 五、其他
如果大家对flutter动态化感兴趣,我们也为大家准备了flutter动态化平台-Fair

欢迎大家使用 Fair，也欢迎大家为我们点亮star  
<br>

Github地址：[https://github.com/wuba/fair](https://github.com/wuba/fair)  
Fair官网：[https://fair.58.com](https://fair.58.com)  
<br>