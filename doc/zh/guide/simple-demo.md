# 从零开始写一个Demo

在Fair接入完成后，我们需要一个bundle才能更显示动态页面，那么怎么编写bundle呢？

这一节我们一起写一个demo页面，并逐步将demo做一些复杂调整。

## 1. 编写红色方块

首先我们写一个红色方块的代码。

下面的代码完全使用flutter编写，入参是一个文本。

```dart
class DynamicWidget extends StatelessWidget {
  final String content;
  const DynamicWidget({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          content,
          style: TextStyle(fontSize: 30, color: Colors.yellow),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.redAccent,
        width: 300,
        height: 300,
      ),
    );
  }
}
```

![](./assets/demo-redbox-1.png)



## 2. 将红色方块动态化展示

现在我们把它转换为Fair能够动态处理的bundle。

第一步：添加注解：

* @FairPatch() 修饰组件的定义，必须是顶级class

```dart
// 修饰当前页面为一个动态bundle资源
@FairPatch()
class DynamicWidget extends StatelessWidget {
  
  final String content;
  const DynamicWidget({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          content,
          style: TextStyle(fontSize: 30, color: Colors.yellow),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.redAccent,
        width: 300,
        height: 300,
      ),
    );
  }
}
```

第二步：现在然我们生成bundle吧

> flutter pub run build_runner build

编译成功后，在build/fair目录下找到同名bundle资源:

* .fair.bin 格式为release产物
* .fair.json 格式为debug产物
* .fair.metadata 格式为元数据，标记了源码与产物的关联信息

![bundle](./assets/demo-redbox-2.png)

第三步：复制产物并使用

现在我们可以把资源拷贝出来，放到assets下（别忘了先在yaml中配置assets目录/路径）

![demo-redbox-3](./assets/demo-redbox-3.png)

```dart
FairWidget(
  path: 'assets/bundle/lib_page_dynamic_widget.fair.bin',
  data: {'content': 'Red Box'},
)
```

重新运行app后，可以看到新的效果，前后效果是像素级别一模一样的。

| Flutter源码效果                              | Fair 动态效果                                |
| -------------------------------------------- | -------------------------------------------- |
| ![demo-redbox-4](./assets/demo-redbox-1.png) | ![demo-redbox-4](./assets/demo-redbox-4.png) |

## 3. 让红色小块复杂一些

现在我们希望重新编写红色小块，让他做一些调整，然后重新渲染出来（为了方便我们任然采用了内置路径，实际上可以通过url路径）。

具体改动如下：

* 把文案改写一下，变成两个名字：张三李四
* 在文字下面加几个图标
* 添加一个网络图片，替换掉红色背景

```dart
@FairPatch()
class DynamicWidget extends StatelessWidget {
  
  final Data data;

  const DynamicWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text.rich(TextSpan(
              text: data.content,
              style: TextStyle(fontSize: 30, color: Colors.yellow),
              children: [
                TextSpan(
                  text: data.content2,
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
              ],
            )),
            Positioned.fill(
              child: Icon(Icons.android, color: Colors.white),
              top: 100,
            ),
            Positioned.fill(
              child: Icon(Icons.people, color: Colors.white),
              top: 100,
              left: 100,
            ),
            Positioned.fill(
              child: Icon(Icons.desktop_mac, color: Colors.white),
              top: 100,
              right: 100,
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 30, bottom: 30),
        decoration: BoxDecoration(
            color: Colors.redAccent,
            image: DecorationImage(image: NetworkImage(data.url))),
        width: 300,
        height: 300,
      ),
    );
  }
}

class Data {
  final String content;
  final String content2;
  final String url;

  Data(this.content, this.content2, this.url);
}
```



编写完代码后，重新生成bundle，app加载新的资源即可。

注意我们的数据原相比一个字段，多了三个，为了方便，这里使用了Bean，当然也可以分散为多个变量：

* bean不能嵌套，名字需要于参数对齐

```dart
FairWidget(
  path: 'assets/bundle/lib_page_dynamic_widget2.fair.bin',
  data: {
    'data.content': '张三',
    'data.content2': '李四',
  'data.url':'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2665922796,3139592461&fm=26&gp=0.jpg'
  },
)
```



| 第一版效果                                   | Fair 动态效果                                |
| -------------------------------------------- | -------------------------------------------- |
| ![demo-redbox-4](./assets/demo-redbox-4.png) | ![demo-redbox-4](./assets/demo-redbox-5.png) |

如果你有服务器，可以把资源托管上去，比如

```dart
FairWidget(
  path:'http://a.b.c/xxx/hello.json',
  name: 'sample_list_view'
)
```

