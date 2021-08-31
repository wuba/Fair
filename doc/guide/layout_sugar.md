# Syntactic sugar

> 以下内容为实验性质，需要手工书写DSL

有时候书写Widget代码会嵌入一些逻辑运算，目前我们支持了少量的模板语法。为了方便区分，所有模板语法关键词形如：`Sugar.xx`

**Fair本身限定了些关键词，书写业务特有代码时请注意规避**

* FairWidget
* Sugar相关API:
* $index
* $item

## ifEqual条件

用于处理二元逻辑判断

**语法格式**

```json
{
  "className":"Sugar.ifEqual",
  "pa":["当前值","期望值"],
  "pa":{
    "trueValue":"条件成立返回值",
    "falseValue":"条件不成立"
  }
}
```

### 示例

根据当前计数器的取值，输出一个文本：

![](./assets/if-else.png)

```dart
Sugar.ifEqual(count, 0,
    trueValue: Text('True case, count = 0'),
    falseValue: Text("False case, count != 0"))
```
等价于

```json
{
    "className": "Sugar.ifEqual",
    "pa": [
        "#($count)",
        0
    ],
    "na": {
        "trueValue": {
            "className": "Text",
            "pa": [
                "True case, count = 0"
            ]
        },
        "falseValue": {
            "className": "Text",
            "pa": [
                "True case, count != 0"
            ]
        }
    }
}
```

## IfRange条件

当你的条件判断是命中一个目标集合时，单纯If标签使得代码非常冗余。因此我们也支持IfRange条件，用于判断当前值是否在一个集合中。

**语法格式**

```json
{
  "className":"Sugar.ifRange",
  "pa":["当前值",["期望值1","期望值2"，"期望值N"]],
  "pa":{
    "trueValue":"条件成立返回值",
    "falseValue":"条件不成立"
  }
}
```



## map操作符

循环控制，适用于Widget接受数组的情况，比如Row，Column的children。

**语法格式**

```json
{
  "className":"Sugar.map",
  "pa":["数组元素1","数组元素1","数组元素N",
  "na": {
     "builder": {"className": "SimpleTextItemBuilder"}
  }
}
```

forloop需要通过硬编码的形式实现一个body体函数，例如SimpleTextItemBuilder, 由他控制for的函数体实现。

注册一个函数可以通过FairApp初始化，也可以通过FairWidget初始化。

```dart
FairApp(
  func: {
    'SimpleTextItemBuilder2': (props) => (text) => Text(text),
  }
)
```

### 示例

遍历字符串数组，并填充为Row的Text数组

![](./assets/forloop.png)

```dart
Row(children:Sugar.map(["=A=", "=B=", "=C=", "=D="], builder: (e) => Text(e)))
```
等价于

```json
{
    "className": "Row",
    "na": {
        "children": {
            "className": "Sugar.map",
            "pa": [
                "=A=",
                "=B=",
                "=C=",
                "=D="
            ],
            "na": {
                "builder": {
                    "className": "SimpleTextItemBuilder"
                }
            }
        }
    }
}
```


## mapEach带索引map操作

如果你的for循环的函数体并不是很复杂，例如只是返回一个Widget，那么可以考虑使用`map`来提高灵活性。

**语法格式**

```json
{
  "className": "Text",
  "mapEach":["A","B","C"],
  "pa":["#($item)"]
}
```

mapEach中为数组，引用数组元素可以通过`$item`,如果要获取当前的索引则通过`$index`

注意变量需要包裹在`#()`中以字符串形式书写。

### 示例

我们输出一行小方块，索引位0和2的小方块设置为黄页背景，其他设置为红色背景。

![](./assets/foreach.png)



```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: Sugar.mapEach(
    ["A", "B", "C", "D"],
    (index, item) => Container(
      child: Text('Card $item'),
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 30, bottom: 30, right: 10),
      color: Sugar.ifRange([0, 2], index,
          trueValue: Colors.redAccent, falseValue: Colors.yellow),
      width: 60,
      height: 60,
    ),
  ).toList(),
)
```

等价于

```json
{
    "className": "Row",
    "na": {
        "mainAxisAlignment": "#(MainAxisAlignment.spaceAround)",
        "children": {
            "className": "Container",
            "mapEach": [
                "A",
                "B",
                "C",
                "D"
            ],
            "na": {
                "child": {
                    "className": "Text",
                    "pa": [
                        "#(Card $item)"
                    ]
                },
                "alignment": "#(Alignment.center)",
                "margin": {
                    "className": "EdgeInsets.only",
                    "na": {
                        "top": 30,
                        "bottom": 30,
                        "right": 10
                    }
                },
                "color": {
                    "className": "Sugar.ifRange",
                    "pa": [
                        "#($index)",
                        [
                            0,
                            2
                        ]
                    ],
                    "na": {
                        "trueValue": "#(Colors.redAccent)",
                        "falseValue": "#(Colors.yellow)"
                    }
                },
                "width": 60,
                "height": 60
            }
        }
    }
}
```