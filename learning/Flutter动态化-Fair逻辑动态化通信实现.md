# Fair逻辑动态化通信实现

前面提到Faris的逻辑动态化是借助js来实现的。这里我们就按照以下几个方面展开介绍：

1. **架构的标准化**
2. **通信协议的实现**
3. **js文件的加载与释放**
4. **数据的绑定**
5. **消息的分发**
6. **第三方扩展（用户根据需要扩展更精彩的功能）**

在介绍之前，我们先了解一下dart转化之后的产物，一个dart文件会被转换为两部分，一部分是json结构的布局文件，而逻辑部分则会转换为js文件。

## 1  架构的标准化

当我们生成了布局文件和逻辑文件，接下来要做的是如何建立他们之间的联系，确切的说是如何建立两者之间的通信。为了方便资源的控制与分配，fair是对每一个逻辑js通过唯一的key确认，然后通过key-value的形式将逻辑文件临时储存在一个全局的集合中。因这个key在生成js的时候是不确定的，所以我们对key统一定义名称为#FairKey#
，在js发送到native侧之前，由dart侧全局替换该值为具体的key。这个key非常重要，在消息通信的时候，需要通过key获取具体的通信对象，js侧dart侧都是。

![通信架构](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f058681314b24f03b6e4d377456d15c5~tplv-k3u1fbpfcp-zoom-1.image)

下面是生成js文件的格式：

 ```
 
 //该对象用于全局管理各个js对象
 let GLOBAL = {};
 
 ...
 
 //\'#FairKey#\'会在发送之前全局统一替换
 GLOBAL[\'#FairKey#\']={
         ...
     //转换之后的js内容，包含对应的变量和方法
         ...
 }
 ```

## 2 通信协议的实现

js与布局文件的通信，本质上就是js与dart之间的通信，因为两者都是以native平台做依托，所以需要native作为消息的转发器，负责消息的分发。对于dart与native之间的通信，我们使用的是官方提供的message-channel与dart:
FFI。message-channel主要有、BasicMessageChannel、MethodChannel、EventChannel，该通道主要用于异步通信，dart:FFI是官方提供的直接调用native
c/c++代码的工具，主要用于同步通信。对于native与js之间的通信，我们则可以用注入方法的形式建立联系，native侧注入本地方法，那么js则可以调用该方法发送消息并获取结果值，而如果是js提供本地方法，
那native侧可以执行js中的方法获取js发送的结果。

### 2.1 格式定义

为了方便数据的统一处理，需要规定数据格式，数据的处理逻辑主要集中在js侧和dart侧，native侧只负责数据的转发，以及js的加载和释放。

```
{    
    pageName:"对应的调用页名称，也就是js侧的#FairKey#",
    funcType:"调用类型，method,variable等",    
    args:{        
        //用户携带的参数，交由js侧处理    
    }
}
```

### 2.2 通道创建

对于通道的创建，目前主要是用了三种，对于js的加载以及释放用的是MethodChannel，对于js-native之间的通信采用的是BasicMessageChannel和dart:
FFI。之所以采用两种通道的原因，也是为了分离加载释放和消息发送的流程。

### 2.3 各侧接口定义

dart侧与js侧的联系，主要是涉及到同步和异步通信，所以在设计接口方法的时候也是做了区分。
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9a7be853319d4ad7a3699a42711cd3e5~tplv-k3u1fbpfcp-zoom-1.image)
为了抹平平台的差异性，对于js侧的通信通过的是方法的注入，native侧只负责消息的转发，不做太多的逻辑，所以js侧只注入了一个方法，逻辑的处理交给js侧处理，方法会根据消息的字段type来执行具体的操作。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/76b346009af549d0b3b1774db5f40d49~tplv-k3u1fbpfcp-zoom-1.image)

## 3 js文件的加载与释放

我们通过对dsl布局的解析生成widget树，用于UI的展示，对于里面的逻辑，我们放到js中去处理。所以我们需要涉及到js的加载，用于数据绑定，当页面销毁之后我们对应的也需要释放掉js，降低对内存的消耗，同时防止出现重复加载问题。

### 3.1 js文件的加载流程

1. 读取本地或者网络的js数据
2. 对js数据包装成固定格式的json字符串
3. 通过method-channel调用native端的加载方法
4. native端js引擎加载成功之后返回消息通知dart端，js加载完成。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8ba96f5b7bc64a73b02270e5e496a9dc~tplv-k3u1fbpfcp-zoom-1.image)

### 3.1 js文件的释放流程

1. 当widget的onDispose回调被执行的时候，调用dart侧的释放方法
2. dart通过method-channel调用native端的释放方法
3. native调用js侧方法，js会根据pageName获取制定的js对象，并将相关对象从集合中移除，后续回收就交给js引擎处理了
4. js移除成功之后，native侧移除相关js-Object，完成释放
5. 释放成功之后通知dart侧，释放过程完成。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0381e2b2f3684427ad3f5cfdfb55261f~tplv-k3u1fbpfcp-zoom-1.image)

## 4 数据的绑定

当js加载完成之后，接下来的工作就是需要做数据的绑定了。对于数据的绑定，绑定的是变量和方法，本文只写方法的调用，对于调用方式会在接下来的文章进行分享。在js加载完成之后，dart端会调用getBindVariableAndFunc方法获取js侧的数据，数据包包括js侧方法名称、变量名称、变量名对应的值。每一个FairWidget都会有一个固定的key，在js侧也会有一个对应的key,dart给js侧发送消息的时候，会通过key获取js侧的对象，然后进行相关操作。dart中的布局被解析成给各个节点，对于里面的js逻辑则会解析成js，js代码中会对应具体的变量以及方法，所以我们要做的是建立dart与js之间的通信，用于获取变量值，执行相关方法等。所有的数据都是在js侧处理，只有js调用setState的方法的时候才会将数据发送到dart侧，刷新页面数据。

获取js侧的数据格式：

```

{
    "func":["方法A名"，"方法B名"]，
    "variable":{
        "变量a名"："变量a值",
        "变量b名"："变量b值",
        "变量c名"："变量c值",
           ... 
    }
} 
```

我们获取到这些数据之后就会将数据绑定到RuntimeFairDelegate中去，当实际调用的时候从里面根据名称取出来对应数据绑定就可以了。

## 5 消息的分发

消息的分发主要是指dart-js两者消息能够正确的发送和接收，而保证消息能够正确的接收发送，是通过FairKey来确定的。消息的发送分两部分，一部分是js发送消息给dart，当用js侧调用setState和调用invokeFlutterCommonChannel的时候会发送消息给dart侧，其中invokeFlutterCommonChannel是native侧注入的方法，setState是js侧注入的方法，是对invokeFlutterCommonChannel的包装；另一部分是dart发送消息给js侧，例如获取js侧绑定数据、调用js侧方法的时候，通过Runtime中的方法即可通信。对于dart侧方法的调用，会有同步调用和异步调用。异步调用的实现方式是通过message-channel,同步则通过dart:
FFI的形式。

### 5.1 通信过程

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cb966fcabc2f4c248efc5ff82a9aeac2~tplv-k3u1fbpfcp-zoom-1.image)

js通信dart(js发送消息到dart主要是异步通信)通过调用js侧invokeFultterChanne方法，将消息发送到native侧，native再对消息转发至dart侧。

### 5.2 dart侧消息的分发

当dart侧接收到js发送的消息的时候，dart侧会对消息分类，然后发送到正确的目标。对与dart侧消息的接收主要是在message
handler的中分发消息，具体分发过程是根据消息的funcName字段作区分，来自js侧的消息目前只有两种，一种是js侧拓展发送过来的消息，第二种是setState发送过来的消息。当funcName名称为invokePlugin的时候是用户拓展模块发来的消息，对setState发送过来的消息，会根据pageName分发到指定的FairWidget中去。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f69b83cb21124a8da84f00b2dc7755b0~tplv-k3u1fbpfcp-zoom-1.image)

## 6 三方拓展

js转dart的时候，有些功能是js不支持的，例如dart端用的通信是Dio，权限调用，拍照，相册选择，那么js转换的时候是有问题的，会因为没有找到对应的类而报错，js只做逻辑处理所以对于这些功能需要用户自定义封装，下面是封装基本流程：

### 6.1 封装dart侧，继承IFairPlugin，并实现里面的getRegisterMethods方法

``` 
//实现IFairPlugin的getRegisterMethods方法，暴露出对应js侧的方法
class FairPhotoSelector extends IFairPlugin {
  Future<dynamic> getPhoto(dynamic map) async {
    //具体的逻辑实现，
    return Future.value();
  }
  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    //用户需要注册方法，这个方法与js侧对应
    functions.putIfAbsent(\'getPhoto\', () => getPhoto);
    return functions;
  }
}
```

### 6.2 封装JS侧

``` 
let FairPhotoSelectorCallback = {};
let FairPhotoSelector = function () {
        return {
        getPhoto: function (req) {
            //调用改方法，将包装的消息发送到dart侧
            invokeFlutterCommonChannel(JSON.stringify(reqMap), function (resp) {
                //处理dart端返回的请求结果
                    ...
                //消费完之后及时移除回调
                FairPhotoSelectorCallback[respCallId] = null;
            });
        },

    };
};
```

### 6.3 注册

``` 

// fair_basic_config.json中注册
{
  "plugin": {
      ...
    "fair_photo": "assets/plugin/sample_fair_photo_selector.js"
  }
}
//main函数中注册用户拓展
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    _getApp(),
    plugins: {
        ...
      'FairPhotoSelector': FairPhotoSelector(),
    },
  );
}
```

### 6.4 开始使用

```  

//开始使用
FairPhotoSelector().getPhoto({
  //pageName为固定格式，方便转换成js之后替换相关值
  'pageName': '#FairKey#',
  'args': {
    'type': 'album',
    'success': (resp) {
      picUrl = resp;
      setState(() {});
    },
    'failure': () {
      //用户获取图片失败
    },
  }
});
```

基本原理就是js将js侧参数包装，通过invokeFlutterCommonChannel方法通知到native侧，native侧再通过messagechannel将消息发送到dart侧，dart侧处理完之后返回相关数据到js侧，js侧接收dart返回的数据，然后执行接下来的逻辑。消息的发送也是通过自定义的消息通道发送，dart会根据消息中的func的值判断，如果是值为invokePlugin，那么则会通过FairPluginDispatcher分发给指定拓展类。

消息发送流程图
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dca691d6ae014bf7b575f4af3bbf3ef6~tplv-k3u1fbpfcp-zoom-1.image)

主要类之间的关系
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a8897dd14a0f45e887cc93bde88637aa~tplv-k3u1fbpfcp-zoom-1.image)

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