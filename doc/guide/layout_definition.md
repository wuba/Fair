# Template
一个动态模板可以看做是Widget树的JSON表示。

## 节点说明
每一个Widget节点有三个关键内容：
1. 组件名称className
2. 参数Positional Arguments，简称pa
3. 命名参数Named Arguments，简称na

## 样例
下面这段代码，是一个动态组件，代表一个300x300的红色正方形，内部嵌套了一个文本标签。

![](./assets/box.png)

```json
{
  "className": "Center",
  "na": {
    "child": {
      "className": "Container",
      "na": {
        "child": {
          "className": "Text",
          "pa": [
            "嵌套动态组件"
          ],
          "na": {
            "style": {
              "className": "TextStyle",
              "na": {
                "fontSize": 30,
                "color": "#(Colors.yellow)"
              }
            }
          }
        },
        "alignment": "#(Alignment.center)",
        "margin": {
          "className": "EdgeInsets.only",
          "na": {
            "top": 30,
            "bottom": 30
          }
        },
        "color": "#(Colors.redAccent)",
        "width": 300,
        "height": 300
      }
    }
  }
}
```