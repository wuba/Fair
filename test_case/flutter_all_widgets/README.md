# flutter_all_widgets

## 组件兼容测试
**widget** | **描述** | **是否解决** | **备注**
:-:|:-:|:-:|:-:
CheckBox |onChanged属性，写法 (value) =>checked = value)； (value) {checked = value;})写法会报"type String is not a subtype of type '(bool?) =>void)?'"| 否||
CheckBox | 不识别 MaterialStateProperty | 否 |
CupertinoTabBar| ([dynamic]) => dynamic' is not a subtype of type '(BuildContext, int) => Widget'| 否| 2022/06/24
OutlinedButton | 不支持 | 是 | 2022/06/23

