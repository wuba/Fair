# flutter_all_widgets

## 组件兼容测试
**widget** | **描述** | **是否解决** | **备注**
:-:|:-:|:-:|:-:
CheckBox | 不支持 V8ScriptCompilationException | 否||
CheckBox | 不识别 MaterialStateProperty | 否 |
CupertinoTabBar| ([dynamic]) => dynamic' is not a subtype of type '(BuildContext, int) => Widget'| 否| 2022/06/24
OutlinedButton | 不支持 | 是 | 2022/06/23
CupertinoAlertDialog | 报错 V8ScriptCompilationException | 否 | 2022/07/05
CircularProgressIndicator | 不支持| 否 | 2022/07/08
RichText | 不支持TextStyle| 否 | 2022/07/11


