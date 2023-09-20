## 项目背景

最近，团队在开发一套在Flutter上能监控用户访问页面路径，以及用户点击行为的全链路日志方案。这就需要Flutter支持无侵入的AOP功能， 在编译或者运行时，替换函数实现，增加埋点代码。 

然而Flutter为了包大小，健壮性等原因禁止了反射。

    
## 实现方案

通过调研，我们可以使用AspectD开源框架实现基于编译期修改 .dill 产物,从而实现aop。 

AspectD是针对Flutter实现的AOP开源库，GitHub地址如下：https://github.com/alibaba-flutter/aspectd。

AspectD让flutter具备了aop的能力，给了我们做全埋点方案很多思路，让很多想法成为可能。

AspectD已经停更一段时间， 且暂未适配Flutter 2.x.x 和 3.x.x版本，所以我们在Aspectd的基础上，创建了house_aspectd, 适配了Flutter 2.5.3 3.0.0版本, 更多版本也在适配中. 

适配其他flutter版本做的事情: 

- flutter_tools.patch重新生成

  - 将flutter SDK切换到对应的版本分支， 再当前分支上进行支持aop代码的编写。
  - 提交改动，再重新生成 flutter_tools.patch。

- frontend_server.snapshot 重新生成

  - 将 house_aspect/inner 文件夹下的Dart的源码，替换为新版本的代码。

  - 修改编译流程，使其支持识别aspectd注解，并重新生成 .dill 文件。

  - 使用命令重新生成 frontend_server.snapshot 文件

    ```shell
    dart --deterministic --snapshot=frontend_server.dart.snapshot starter.dart 
    ```


### house_aspectd的接入

#### Apply flutter_tools

```ruby
cd path/to/flutter
git apply path-for-house_aspectd-package/inner/flutter_tools.patch
rm bin/cache/flutter_tools.stamp
```

删除flutter_tools.stamp后， 当在下次编译Flutter工程时，flutter_tools就会重新build。 



#### 添加Aspectd依赖

```ruby
dependencies:
  house_aspectd:
		path: ../path/house_aspectd
```



#### 将aop_config.yaml添加到工程.

在工程根目录下添加一个aop_config.yaml文件(和pubspec.yaml同一级), 内容如下: 

```dart
flutter_tools_hook:
  - project_name: 'house_aspectd'
```

Flutter_tools会检查这个文件来判断house_aspectd是否生效。



#### 添加hook代码

例如, hook_example.dart (用于实现 aop)

```dart
import 'package:house_aspectd/aspectd.dart';

@Aspect()
@pragma("vm:entry-point")
class CallDemo {
  @pragma("vm:entry-point")
  CallDemo();

 //实例方法
 @Call("package:example/main.dart", "_MyHomePageState",
     "-_incrementCounter")
 @pragma("vm:entry-point")
 void _incrementCounter(PointCut pointcut) {
   print('call instance method2!');
   pointcut.proceed();
 }
}
```

在main.dart中引用此文件,  以免被编译器优化掉。 当我们重新运行项目时，_MyHomePageState中 _incrementCounter 方法触发时， 就会调用到 hook_example 中添加的_incrementCounter方法。 

注解含义：

- @Aspect()
  - 需要使用@Aspect()注解来标记类，以便aspectd知道该类包含AspectD的 annotation（表示面向切面编程）信息。
- @pragma('vm:entry-point')
  - 在AOT编译中，如果没有被引用到的代码会丢弃掉，而AOP代码是不会被引用，需要使用该方式告诉编译器不要丢弃代码

- @Call
  - @Call会修改调用的地方，并不会修改原始方法的内部。

- @Execute
  - @Execute会修改原有方法的内部。
- @inject
  - @inject就是往具体的行前插入代码。



### house_aspectd应用

在房产flutter全链路日志收集中，通过house_aspectd，实现了对用户点击事件行为记录， 以及用户页面访问路径的全局监控。 具体如下:

#### 用户行为记录

- 用户行为记录是用户的点击事件， 可以通过hook一个package下的所有方法，统一拦截，代码如下: 

  ```dart
    // 实例方法
    @Call("package:demo_project_flutter\\/.+\\.dart", ".*", "-.*", isRegex: true)
    @pragma("vm:entry-point")
    dynamic _instanceMethod(PointCut pointcut) {
  
      var timeStamp = DateTime.now().millisecondsSinceEpoch;
      log('[aspectd]: instanceMethod call start -----------------------' + 'currentTimeStamp is + ' + timeStamp.toString());
  
      log( 'target is ' + pointcut.target.toString() + '     ' + 'function is ' +  pointcut.function);
      var ret = pointcut.proceed();
  
      var diff = DateTime.now().millisecondsSinceEpoch - timeStamp;
      log('[aspectd]: instanceMethod call end -----------------------' + 'currentTimeStamp is + ' + DateTime.now().millisecondsSinceEpoch.toString() + '    duration is ' + diff.toString() + 'ms' + '\n\n');
      return ret;
    }
  ```

- pointcut.proceed() 是调用原始原始方法, 可以在调用前后，分别获取时间戳， 得到方法耗时等。 

- 获取日志后， 通过channel 把日志写到本地， 当需要上传时， 再把进行本地日志上传操作。 



#### 用户页面访问记录

页面访问记录，因目前房产项目都是通过house_flutter_base中的 HouseFlutter.instance.open 方法跳转， 故可以通过hook以上方法获取用户页面访问记录，代码如下:

```dart
  // house_flutter_base 路由方法
  @Call("package:flutter_house_base/src/house/house_flutter.dart", "HouseFlutter", "-open")
  @pragma("vm:entry-point")
  dynamic _openMethod(PointCut pointcut) {

    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    log('[aspectd]: _openMethod call start -----------------------' + 'currentTimeStamp is + ' + timeStamp.toString());
    log('routeUrl is ' + pointcut.positionalParams[0].toString() + '   routeParams is ' + pointcut.namedParams.toString());
    var ret = pointcut.proceed();

    var diff = DateTime.now().millisecondsSinceEpoch - timeStamp;
    log('[aspectd]: _openMethod call end -----------------------' + 'currentTimeStamp is + ' + DateTime.now().millisecondsSinceEpoch.toString() + '    duration is ' + diff.toString() + 'ms' + '\n\n');

    return ret;
  }

```

效果展示:

![QQ20230322-151731-HD](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/89eb62395f02450882e0a403f05d284b~tplv-k3u1fbpfcp-zoom-1.image)

## 原理解析

AspectD是基于编译期根据注解，修改生成的 .dill 产物的方式完成代码插桩，要想理解其原理， 我们需要对 Flutter的编译流程做一些了解。 

### 了解Flutter编译流程

![<u>image-20230309145242213</u>](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c166a70a8a7e4685a75b0bd0a0e83fcd~tplv-k3u1fbpfcp-zoom-1.image)



如上图，flutter在编译时，首先由flutter_tools调用编译前端frontend_server, 前端编译器将dart代码转换为AST，并生成app.dill文件，然后在debug模式下，将app.dill转换为kernel_blob.bin，在release模式下，app.dill被转换为framework或者so。

house_aspectd的aop就是通过修改编译前端的编译过程，达到对app.dill进行修改的目的。

所以我们主要看下， **Dart  ->  app.dill** 这一步所做的事情。 



#### ![image-20230316112522594](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c9a92f12f2bc4b7e96ebdc0e68ee3c04~tplv-k3u1fbpfcp-zoom-1.image)



如何让Flutter 的编译过程中能使用我们自己的 frontend_server 呢？以及如何修改 frontend_server生成新的app.dill呢? 



问题一:  修改 **flutter_tools**, 就需要在修改 flutter sdk 中代码， 再重新生成 flutter_tools.snapshot，因为我们并不能修改官方flutter sdk的代码,  所以就需要fork自己的flutter仓库通过git patch生成补丁，并通过git apply的方式修改本地的flutter sdk代码。  

问题二:  修改frontend_server代码，重新生成 frontend_server.dart.snapshot。 用新生成的snapshot产物替换sdk中自带的。 

``` dart
// frontend_server路径
/opt/fvm/versions/2.5.3/bin/cache/dart-sdk/bin/snapshots/frontend_server.dart.snapshot

// flutter_tools 路径
/opt/fvm/versions/2.5.3/bin/cache/flutter_tools.snapshot
```



### git patch 和 git apply做了什么事？

git patch就是修改了flutter_tools的编译流程， 让其在编译时替换 frontend_server.snapshot, 并且根据aspectd的注解修改 .dill 文件。

1. fork 一份flutter sdk到自己仓库。
2. 在自己仓库里修改 flutter_tools 文件夹下的代码，添加支持替换 frontend_server.snapshot 等逻辑。
3. 使用 git format-patch 生成 .patch补丁。
4. 最后 cd 到电脑上安装的flutter路径， 执行 git apply xx/xx/xx.patch。

以上步骤执行完毕， 我们就可以查看本地flutter sdk 的修改。 具体文件修改如下图:

![image-20230310161711805](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/074bff3c5e87495fb481b0d0a015620a~tplv-k3u1fbpfcp-zoom-1.image)

然后，我们来大致缕一下添加的逻辑。

1. compile时，增加enableAspectd() 

``` dart
  await AspectdHook.enableAspectd();
```

2. enableAspectd()
   - 判断是否存在 aop_config.yaml 文件。
   - 如果存在查看是否替换过 frontend_server.snapshop。
   - 如果替换过， 则直接进入编译流程。 如果未替换过， 则替换， 替换完毕走编译流程。
3. 这样就实现了在flutter build时替换编译期前端，实现走自定义逻辑。 

![aspectd原理1](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/32abce283c774ea4b152d06171b4e181~tplv-k3u1fbpfcp-zoom-1.image)



### 调试frontend_server

house_aspectd主要对flutter的两个流程就行了修改: 

- flutter_tools (修改使编译使用我们的 frontend_server.dart.snapshot)
- frontend_server (修改编译流程，根据asptctd注解修改 .dill 文件)

我们的调试主要针对 frontend_server, 查看其是如何在编译过程中，修改 .dill 文件的。 具体的如何进行调试可以参考另一个文档， 这里我们通过调试学习一下dill文件是如何被修改的。 

源码解读frontend_server

#### starter.main

``` dart
void main(List<String> args) async {
  final int exitCode = await starter(args);
  ...
}
```

#### server.starter

``` dart
Future<int> starter(
    List<String> args, {
      frontend.CompilerInterface compiler,
      Stream<List<int>> input,
      StringSink output,
    }) async {
  ...
  //解析参数
  ArgResults options = frontend.argParser.parse(args);
  //创建前端编译器实例对象
  compiler ??= _FlutterFrontendCompiler(output,
      transformer: ToStringTransformer(transformer, deleteToStringPackageUris),
      useDebuggerModuleNames: options['debugger-module-names'] as bool,
      emitDebugMetadata: options['experimental-emit-debug-metadata'] as bool,
      unsafePackageSerialization:
          options['unsafe-package-serialization'] as bool,
      aopTransform: options['aop'].toString() == '1' ? true : false);
  
  if (options.rest.isNotEmpty) {
    //解析命令行的剩余参数
    return await compiler.compile(options.rest[0], options) ? 0 : 254;
  }
  ...
}
```

此方法主要工作:

完成了编译器前端compiler的替换，替换成了aspectd提供的 _FlutterFrontendCompiler， 执行编译操作。



#### FlutterFrontendCompiler

aspectd提供的 _FlutterFrontendCompiler ，主要覆写了接口frontend.CompilerInterface接口的方法，并实现了 compiler 方法，具体如下:

```dart
  @override
  Future<bool> compile(String filename, ArgResults options,
      {IncrementalCompiler generator}) async {
    print('aop: need perform ' + aopTransform.toString());
    
    if (aopTransform == true &&
        !FlutterTarget.flutterProgramTransformers
            .contains(aspectdAopTransformer)) {
      FlutterTarget.flutterProgramTransformers.add(aspectdAopTransformer);
    }

    return _compiler.compile(filename, options, generator: generator);
  }

```

通过源码可以发现， 其增加了 aspectdAopTransformer 参与编译，即引入了我们的核心成员**aspectdAopTransformer**，该实例是**AopWrapperTransformer()**类型，来自于**aop_transformer.dart**



#### AopWrapperTransformer

该类是 FlutterProgramTransformer 的子类，主要覆写了 transform 方法

```dart
  @override
  void transform(Component program) {
    for (Library library in program.libraries) {
      componentLibraryMap.putIfAbsent(
          library.importUri.toString(), () => library);
    }
    program.libraries.forEach(_checkIfCompleteLibraryReference);
    final List<Library> libraries = program.libraries;

    if (libraries.isEmpty) {
      return;
    }

    // 核心代码
    _resolveAopProcedures(libraries);
    ...
  }
```

**_resolveAopProcedures(libraries)**完成的功能是从libraries中遍历每个class，然后有aspectD注解class上的注解信息捕获到，然后实例化AopItemInfo添加至aopItemInfoList中。

- ##### 遍历 aopItemInfoList， 把有注解的方法分类存放

```dart
for (AopItemInfo aopItemInfo in aopItemInfoList) {
  if (aopItemInfo.mode == AopMode.Call) {
    callInfoList.add(aopItemInfo);
  } else if (aopItemInfo.mode == AopMode.Execute) {
    executeInfoList.add(aopItemInfo);
  } else if (aopItemInfo.mode == AopMode.Inject) {
    injectInfoList.add(aopItemInfo);
  } else if (aopItemInfo.mode == AopMode.Add) {
    addInfoList.add(aopItemInfo);
  }
}
```

注解分为几类，这里我们着重看一下AopMode.Call这种类型的代码如何转换。使用 AopCallImplTransformer

该类继承了 Transformer, 覆写了相关的方法， 这里主要看一下 visitInstanceInvocation

```dart
@override
  InstanceInvocation visitInstanceInvocation(
      InstanceInvocation instanceInvocation) {
    instanceInvocation.transformChildren(this);

    final Node node = instanceInvocation.interfaceTargetReference?.node;
    String importUri, clsName, methodName;
    if (node is Procedure || node == null) {
      ...
      final AopItemInfo aopItemInfo = _filterAopItemInfo(
          _aopItemInfoList, importUri, clsName, methodName, false);
      
      return transformInstanceMethodInvocation(
            instanceInvocation, aopItemInfo);
    }
    return instanceInvocation;
  }
```

主要逻辑就是通过**methodInvocation**获取到基础的importUri、clsName、methodName，然后通过_filterAopItemInfo筛选出符合条件的aopItemInfo，然后调用**transformInstanceMethodInvocation**。该方法通过字面意思理解是完成类的实例方法的切面插入。

​ ![image-20230310171225892](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9f19de2c2e714575b5dbd18f44ecb757~tplv-k3u1fbpfcp-zoom-1.image)

#### transformInstanceMethodInvocation

该方法就是核心的更改原始调用， 开始处理 stubKey, methodImplClass, methodProcedure等信息， 然后生成methodInvocationNew， 再调用 insertInstanceMethod4Pointcut,  insert方法中记录了切面信息和原始代码。



#### insertInstanceMethod4Pointcut

看代码，此方法中创建了一个 mockedInvocation ，然后调用 createPointcutStubProcedure

```dart
bool insertInstanceMethod4Pointcut() {
    
    //Add library dependency
    //Add new Procedure
    ...
    final InstanceInvocation mockedInvocation = InstanceInvocation(
        InstanceAccessKind.Instance,
        AopUtils.concatArguments4PointcutStubCall(
            originalProcedure, aopItemInfo),
        interfaceTarget: originalProcedure,
        functionType: originalInvocation.functionType);
    ...
    createPointcutStubProcedure(
        aopItemInfo,
        stubKey,
        pointCutClass,
        AopUtils.createProcedureBodyWithExpression(mockedInvocation,
            !(originalProcedure.function.returnType is VoidType)),
        shouldReturn);
    return true;
  }
```



#### createPointcutStubProcedure

最后调用AopUtils.insertProceedBranch 完成代码的插入。 

```dart

  //Will create stub and insert call branch in proceed.
  void createPointcutStubProcedure(AopItemInfo aopItemInfo, String stubKey,
      Class pointCutClass, Statement bodyStatements, bool shouldReturn) {
    final Procedure procedure = AopUtils.createStubProcedure(
        Name(stubKey, AopUtils.pointCutProceedProcedure.name.library),
        aopItemInfo,
        AopUtils.pointCutProceedProcedure,
        bodyStatements,
        shouldReturn);
    pointCutClass.procedures.add(procedure);
    if(procedure.isStatic) {
      procedure.parent = pointCutClass.parent;
    } else {
      procedure.parent = pointCutClass;
    }

    AopUtils.insertProceedBranch(pointCutClass, procedure, shouldReturn);
  }
```



#### 以上流程完成后， 调用 writeDillFill 覆盖原有 .dill 文件。

![image-20230310173812619](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3a38610ac6354892a3b23afb3ca8b095~tplv-k3u1fbpfcp-zoom-1.image)



### .dill文件查看验证

dill文件是dart编译的中间文件，是flutter_tools调用frontend_server将dart转换生成的。我们可以在工程的build目录下找到编译生成的dill文件。通过查看 .dill 文件可以查看我们的hook代码是否生效。

Dill文件本身是不可读的，我们可以通过dart vm中的dump_kernel.dart来将dill文件转换为可读的文件。

1. 首先需要下载 Flutter 对应的dart sdk。 下载完后，找到对应版本的revition, 可以通过path_to_flutter/bin/cache/dart-sdk/revision文件中找到。 
2. cd到下载的dart sdk路径， 执行 git checkout 刚找到的revision
3. 执行如下脚本:

```ruby
path_to_flutter/bin/cache/dart-sdk/bin/dart  path_to_dart/pkg/vm/bin/dump_kernel.dart path_to_your_project/.dart_tool/flutter_build/***/app.dill output_path/out.dill.txt
```

4. 打开 output.dill.txt文件，找到hook的方法，确认是否被替换。 



hook 前后 dill.txt 文件的对比，hook _incrementCounter 之前dill文件如下: 

![image-20230316145805834](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8e5d6a96278147258f5f1b9565a10234~tplv-k3u1fbpfcp-zoom-1.image)

hook _incrementCounter 之后 .dill文件如下 : 

![image-20230310155310911](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4917eb4b502643428d205cecb897d6c3~tplv-k3u1fbpfcp-zoom-1.image)

通过对比，可以看出_incrementCounter的调用已被修改。 此时，我们触发_incrementCounter方法时，将会走进hook的方法中。 


## 团队介绍

**Fair团队**来自58集团开源小组，设计并实现了**Flutter动态化的全流程解决方案——Fair**的核心功能，把控模块的功能规划、特性引入和实现进度，当社区无法达成共识时做出最终决定。


如果对Flutter&Fair相关技术感兴趣，

欢迎大家加入我们，一起共建Fair，共建Flutter生态，也欢迎大家为我们点亮star~

Github地址：[https://github.com/wuba/fair](https://github.com/wuba/fair)  
Fair官网：[https://fair.58.com](https://fair.58.com)  
<br>
