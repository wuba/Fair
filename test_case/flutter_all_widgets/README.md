# flutter_all_widgets

## 组件兼容测试
**widget** | **是否有问题** | **是否解决** | **时间**
:-:|:-:|:-:|:-:
CheckBox | 是 V8ScriptCompilationException | 否| 2022/06/24 |
CheckBox | 是 不识别 MaterialStateProperty | 否 | 2022/06/24 |
CupertinoTabBar| 是 ([dynamic]) => dynamic' is not a subtype of type '(BuildContext, int) => Widget'| 否| 2022/06/24
OutlinedButton | 否 |  | 2022/06/23
CupertinoAlertDialog | 是 报错 V8ScriptCompilationException | 否 | 2022/07/05
CircularProgressIndicator | 不能生成产物| 否 | 2022/07/08
RichText | 是 | 否 | 2022/07/11
AbsorbPointer | 是 ElevatedButton：formatException:Unexpected character(at character 1) jsAppObj is null | 否 |2022/07/14
TextButton | 是 | 是 | 2022/07/15
AlertDialog | 不支持 | 否 | 2022/07/15
AnimatedAlign | 是 | 是 |2022/07/15
AnimatedBuilder | 是`FormatException` | 否 | 2022/07/18
AnimatedContainer | 是 | 是 | 2022/07/18
AnimatedDefaultTextStyle | 是 | 是 | 2022/07/20
AnimatedCrossFade | 是 | 是 | 2022/07/21
AnimatedListState | 是 com.eclipsesource.v8.V8ScriptExecutionException | 否 | 20122/07/22
AnimatedModalBarrier | Failed parse ast; | 否 | 2011/07/22
AnimatedOpacity | 是 | 是 | 2022/07/22
AnimatedPhysicalModel | 否 | | 2022/07/27
AnimatedPositioned | 否| | 2022/07/28
AnimatedSize | 否 | | 2022/07/28






