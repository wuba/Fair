# 支持动态逻辑运算的界面

## 使用场景
    支持对一个界面中，基础类型和自定义类型（未继承Flutter组件）的动态化，区别于delegate的预埋变量和方法，逻辑动态化可以自动完成变量和方法分绑定和调用。

## 预览效果

![listCell](./assets/sample_logic_page.jpg)

## 集成方式
### 1、State 内定义变量（支持基础类型和纯自定义类型；同Flutter原生开发）
    如sample示例中，定义的DemoList对象
    DemoList _demoList = DemoList(list: List.empty(), total: 0);

### 2、State Build中的变量使用（同Flutter原生语法支持）
#### 基础类型
     Text('$total'),
#### 自定义对象类型
     Text('${_demoList.total}'),

### 3、生命周期
#### onLoad
    变量初始化方法，需要声明单独的onLaunch，来完成数据的初始化，以及网络访问等操作。
    在原生开发时，一般在initState中调用；在动态界面中使用时，会在逻辑文件初始化之后调用。

#### onUnload
    如果有资源需要回收，需要声明单独的onDispose方法。
    在原生开发时，一般在dispose中调用；在动态界面中使用时，会在Widget销毁之后调用。

### 4、绑定事件
    建议把onTap、onPressed等处理方法独立成方法。如示例中onPressed的响应方法：

    // 定义方法
    void onTapText() {
        setState(fairProps['pageName'], {_demoList.total: _demoList.total++});
    }

    // 绑定方法
    FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onTapText,
    )

### 5、逻辑处理（同Flutter原生开发）
    如示例中，用户点击一次"加"号按钮，数值加一
    _demoList.total++

### 6、数据同步
#### 指定变量同步，需要在参数Map中，指定同步的变量名和结果，如下：
    setState({_demoList.total: _demoList.total++});
#### 全量，传递参数Map，为空即可，如下：
    setState({});

### 关于变量
#### Flutter内部类型变量支持方式
    可以实用Fair框架中的delegate来完成，类型的预埋。可参考加载更多List的示例。
    
    