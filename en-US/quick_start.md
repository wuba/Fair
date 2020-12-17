# Getting started

1. 标题：Flutter Fair接入
2. 地址：https://fair.hacktons.cn/guide/usage.html#%E6%B7%BB%E5%8A%A0%E4%BE%9D%E8%B5%96
3. 归档：请将当前译文单独书写为md文档，放置于en-US/目录下
4. 参考：https://fair.hacktons.cn

## add dependency

**import Fair as a dependency int the *pubspec.yaml* file.**

```
# add Fair dependency
dependencies:
  fair:
    git:
      url: https://github.com/wuba/fair.git
      ref: master
      path: fair
# add compiler dependency
dev_dependencies:
  build_runner: ^1.4.0
  fair_compiler:
    git:
      url: https://github.com/wuba/fair.git
      ref: master
      path: fair_compiler
```

**In order to access Fair mre conveniently and  experience Fair better,please check the runtime environment on your computer.Fair is based on Flutter 1.20.4 & 1.22.4 .The latest stable flutter version will continue to be supported in the future. Currently supported versions are as follows... (If you encounter problems, issue feedback):**

**To be compatible with flutter,you need to get right fair version.For example,when you checkout the flutter version 1.12.13,fair needs to switch synchronously (1.20.4 is supported by default)**

```
# Switch to another stable flutter version
dependency_overrides:
  fair_version:
    git:
      url: https://github.com/wuba/fair.git
      ref: master
      path: fair_version/flutter_1_12_13
```

# Using Fair

**The steps to access Fair in the App are as follows:**

​	1. **making *FairApp* as top widget node of the dynamization widget tree**

**The common practice is that *Fair App* serve as the root node of the App.Of course, you can use it as root node of the page view**

```
void main() {
  runApp(
    FairApp(
      child: MaterialApp(home: App())
    ),
  );
}
```

2. **add dynamization widget**

```
FairWidget(
  type: "video_card",
  data: {
    "url": 'assets/bundle/video_card.json',
  },
)
```

**In fair, a FairWidget represents a dynamization widget**

**According to different conditions,FairWidget and flutter widget can be mixed,such as:**

* **FairWidget can work with other different widgets**

* **In general,FairWidget displays as a full screen page widget**
  * **FairWidget can be nested.That is to say  it can be partially nested under a common flutter Widget, or it can be nested under another FairWidget**

---------



**Assignees**

[ME-smile]: https://github.com/ME-smile


