# Fish Redux理解与使用

## Fish Redux理解
### 类比于房产详情页：
1、详情页是一个自由组合的页面，通过server传递的数据进行动态化页面拼接，不同的key对应不同的ctrl，ctrl控制某一部分组件的展示和逻辑。  
2、不同的Ctrl完成了之后，需要一个Adapter组合在一起，  
3、controllers需要注册在一个注册表文件中，用于Adapter查找  
4、由Activity的生命周期传递给controller进行生命周期管理

### Fish Redux同样做了相同的事：
1、只是将我们的ctrl改成了state+view+effect等。  
2、同样有个Adapter的组件，次组件也是为了组合不同的Component  
3、不同的Component组件需要注册到Adapter或者Page或者Component中  
4、通过LifeCycle，进行生命周期Action的响应

## Fish Redux做的不同的事
相比于Ctrl，fish redux多做了三件事：<br>  
1、局部刷新  
2、逻辑、布局解耦  
3、Component间的通信

### 如何实现的局部刷新
Flutter本身自带的刷新是，StateWidget，每次通过setState进行刷新。如果想要实现局部刷新，开发者需要判断当前的state的某些字段是否发生了改变，如果改变了，则刷新此处的View，如果没有则不进行重绘，使用Cache中的内容进行绘制页面。<br><br>
Fish Redux对于此场景的处理，也类似，在获取到更新请求时，从外到内，一层一层进行传递，类似于touch事件的分发。每一层都可以判断是否继续向自己的子Component进行传递。<br><br>
从Page层级开始，首先判断oldState是否与newState是否相等，这个是否相等的判断只判断地址是否相同，因此，每次需要更新时，一般调用的是state.clone直接进行更新。<br><br>
当Page层级发现State已经不同，更新时，将遍历所有持有的Component，Page和Component中存在一个Connector，这个Connector对于刷新有两个比较重要的方法，一个是computed一个是factors，只有当factors返回的值有改变时，才会调用computed，computed返回的就是Component需要接收的State，只有这个State有变化时，对应的Component才会进行改变。<br><br>

``` dart 
//page
class _PageState<T, P> extends State<_PageWidget<T, P>> {
  Store<T> _store;
  DispatchBus _pageBus;

  final Map<String, Object> extra = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _store = widget.page.createStore(widget.param);
    _pageBus = widget.page.createPageBus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Register inter-page broadcast
    _pageBus.attach(widget.page.appBus);
  }

  @override
  Widget build(BuildContext context) {
    // return PageProvider(
    //   store: _store,
    //   extra: extra,
    //   child:
    // );

    return widget.page.buildComponent(
      _store,
      _store.getState,
      bus: _pageBus,
      enhancer: widget.page.enhancer,
    );
  }

  @override
  void dispose() {
    _pageBus.detach();
    _store.teardown();
    super.dispose();
  }
}
```

``` dart
//创建Component
  @override
  Widget buildComponent(
    Store<Object> store,
    Get<T> getter, {
    @required DispatchBus bus,
    @required Enhancer<Object> enhancer,
  }) {
    assert(bus != null && enhancer != null);
    assert(isComponent(), 'Unexpected type of ${logic.runtimeType}.');
    final AbstractComponent<P> component = logic;
    return component.buildComponent(
      store,
      () => connector.get(getter()),
      bus: bus,
      enhancer: enhancer,
    );
  }


```

``` dart
//Component刷新的部分代码
abstract class Component<T> extends Logic<T> implements AbstractComponent<T> {
  ViewBuilder<T> get protectedView => _view;
  ShouldUpdate<T> get protectedShouldUpdate => _shouldUpdate;
  …

  @override
  ComponentContext<T> createContext(
    Store<Object> store,
    BuildContext buildContext,
    Get<T> getState, {
    @required void Function() markNeedsBuild,
    @required DispatchBus bus,
    @required Enhancer<Object> enhancer,
  }) {
    assert(bus != null && enhancer != null);
    return ComponentContext<T>(
      logic: this,
      store: store,
      buildContext: buildContext,
      getState: getState,
      view: enhancer.viewEnhance(protectedView, this, store),
      shouldUpdate: protectedShouldUpdate,
      name: name,
      markNeedsBuild: markNeedsBuild,
      sidecarCtx: adapterDep()?.createContext(
        store,
        buildContext,
        getState,
        bus: bus,
        enhancer: enhancer,
      ),
      enhancer: enhancer,
      bus: bus,
    );
  }

  @mustCallSuper
  @override
  void didUpdateWidget(ComponentWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _ctx.didUpdateWidget();
    _ctx.onLifecycle(LifecycleCreator.didUpdateWidget());
  }
}

//Context的代码
Context{
  @override
  void didUpdateWidget() {
    final T now = state;
    if (shouldUpdate(_latestState, now)) {
      _widgetCache = null;
      _latestState = now;
    }
  }

  @override
  void onNotify() {
    final T now = state;
    if (shouldUpdate(_latestState, now)) {
      _widgetCache = null;

      markNeedsBuild();

      _latestState = now;
    }
  }

}

```

``` dart
  //如何调用的获取Component的state
  @override
  Widget buildComponent(String name, {Widget defaultWidget}) {
    assert(name != null, 'The name must be NotNull for buildComponent.');
    final Dependent<T> dependent = logic.slot(name);
    final Widget result = dependent?.buildComponent(store, getState,
        bus: bus, enhancer: enhancer);
    assert(result != null || defaultWidget != null,
        'Could not found component by name "$name." You can set a default widget for buildComponent');
    return result ?? (defaultWidget ?? Container());
  }
```

``` dart
  ///获取state
  @mustCallSuper
  @override
  P get(T state) {
    final List<dynamic> newFactors = factors(state);
    if (!_hasBeenCalled || !_listEquals(newFactors, _cachedFactors)) {
      _cachedFactors = newFactors.toList(growable: false);
      _cachedResult = computed(state);
      _hasBeenCalled = true;
    }
    return _cachedResult;
  }
```

### 逻辑和布局的解耦
#### 常用的文件：  
action.dart<br>
adapter.dart<br>
connector.dart<br>
effect.dart<br>
page.dart<br>
reducer.dart<br>
state.dart<br>
view.dart<br>

#### 页面主要用于页面展示
``` dart
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commercial/common/colors.dart';
import 'package:flutter_commercial/common/constants.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DynamicsDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: <Widget>[
        SafeArea(
          bottom: false,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: 44),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20,10,20,10),
                      child: Text(
                        CommercialConstants.TITLE_CANCEL,
                        style: TextStyle(
                            fontSize: 15,
                            color: CommercialColors.black_33
                        ),
                      ),
                    ),
                    onTap: () => Navigator.pop(viewService.context),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "发布新动态",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
              child:  Column(
                children: <Widget>[
                  viewService.buildComponent("title"),
                  viewService.buildComponent("content"),
                  viewService.buildComponent("video"),
                  viewService.buildComponent("image"),
                ],
              ),
            ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow:[
              BoxShadow(
                  color: CommercialColors.color_f6f6f6,
                  offset: Offset(0.0, -4.0),
                  blurRadius: 16.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: GestureDetector(
              onTap: (){
                dispatch(DynamicsDetailActionCreator.uploadDynamic());
              },
              child: Container(
                height: 48,
                decoration: _isBtnClickable(state)?
                BoxDecoration(
                    gradient: LinearGradient(colors: [
                      CommercialColors.color_228EFF,
                      CommercialColors.color_1B81EA
                    ]),
                    borderRadius: BorderRadius.circular(4)
                ):BoxDecoration(
                    color: CommercialColors.color_f6f6f6,
                    borderRadius: BorderRadius.circular(4)
                ),
                alignment: Alignment.center,
                child: Text(
                  "发布",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isBtnClickable(state)
                          ?Colors.white:CommercialColors.grey_66,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

bool _isBtnClickable(DynamicsDetailState state){
  return state.editCompleted();
}
```

#### effect类似于房产详情页Ctrl的逻辑改变，修改某些字段值或者点击事件
``` dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_commercial/http.dart';
import 'package:flutter_commercial/publish/meidaEdit/action.dart';
import 'package:flutter_commercial/util/toast_util.dart';
import 'package:magpie/magpie.dart';
import 'package:media_upload/media_upload.dart';

import 'action.dart';
import 'state.dart';

Effect<DynamicsDetailState> buildEffect() {
  return combineEffects(<Object, Effect<DynamicsDetailState>>{
    DynamicsDetailAction.uploadDynamic: _uploadDynamic,
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
  });
}

Future<void> _uploadDynamic(Action action, Context<DynamicsDetailState> ctx) async {
  DynamicsDetailState state =  ctx.state;
  String url = state.uploadUrl;
  Response response;
  try {
    response = await dio.post(url,
        data: jsonEncode(state.toUploadJson()),
        options: Options(headers: {'Content-Type': 'application/json'}));
  } catch (e) {
    print(e);
    if(e is DioError){
      String errorStr = e.response.data['msg'];
      ToastUtil.toast(msg: errorStr);
    } else{
      ToastUtil.toast(msg: "保存失败");
    }
    return;
  }
  if(response?.data != null){
    //成功
    Magpie.singleton.closeCurrent();
    ToastUtil.toast(msg: "保存成功");
  } else{
    //失败
    ToastUtil.toast(msg: "保存失败");
  }
}

void _initState(Action action, Context<DynamicsDetailState> ctx) {
  ctx.state.uploadListener = (taskId, item)=>{
    ctx.dispatch(ImageEditActionCreator.onMediaUpload(taskId, item))
  };
  MediaUpload.instance.addUploadListener(ctx.state.uploadListener);

  //初始化页面
  ctx.state.fillNullObject();

  requestData(ctx);
}

Future<void> requestData(Context<DynamicsDetailState> ctx) async{
  String url = ctx.state.dataUrl;
  Response response = await dio.get(url);
  println(response);
  DynamicsDetailState contentState = DynamicsDetailState.fromJson(response.data);
  contentState.fillNullObject();
  contentState.uploadUrl = ctx.state.uploadUrl;
  contentState.uploadListener = ctx.state.uploadListener;
  contentState.dataUrl = ctx.state.dataUrl;
  contentState.isEdit = ctx.state.isEdit;
  ctx.dispatch(DynamicsDetailActionCreator.refreshPage(contentState));
}

void _dispose(Action action, Context<DynamicsDetailState> ctx) {
  if(ctx.state.uploadListener != null){
    MediaUpload.instance.deleteUploadListener(ctx.state.uploadListener);
  }
}
```

#### reducer类似于房产详情页异步更新，或者界面更新等。
``` dart

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_commercial/publish/meidaEdit/action.dart';
import 'package:flutter_commercial/publish/meidaEdit/image/display/state.dart';
import 'package:flutter_commercial/publish/meidaEdit/image/state.dart';
import 'package:flutter_commercial/publish/meidaEdit/video/state.dart';
import 'package:flutter_commercial/publish/propertiesEdit/action.dart';
import 'package:media_upload/UploadTaskItem.dart';
import 'package:media_upload/constants.dart';

import 'action.dart';
import 'state.dart';

Reducer<DynamicsDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<DynamicsDetailState>>{
      HousePropertiesEditAction.refreshState: _refreshState
    },
  );
}

DynamicsDetailState _refreshState(DynamicsDetailState state, Action action){
  return state.clone();
}

```

#### Action用于创建动作，该动作用于在Effect或者reducer中注册
``` dart
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_commercial/publish/dynamicDetail/state.dart';

enum DynamicsDetailAction { action, refreshPage, uploadDynamic }

class DynamicsDetailActionCreator {
  static Action uploadDynamic() {
    return const Action(DynamicsDetailAction.uploadDynamic);
  }

  static Action refreshPage(DynamicsDetailState state) {
    return Action(DynamicsDetailAction.refreshPage, payload: state);
  }
}

```

#### Adatper，就类似于RecyclverView的Adapter，用于注册Component
``` dart

import 'package:fish_redux/fish_redux.dart';

import 'itemImage/component.dart';
import 'itemText/component.dart';
import 'state.dart';

class DetailAdapter extends SourceFlowAdapter<HouseDetailEditPageState>{

  DetailAdapter() :
        super(
          pool: <String, Component<Object>>{
            'text': PublishItemTextComponent(),
            'image': PublishItemImageComponent()
          },
      );
}
```

#### Connector用于将外层的State转化成内部的State
``` dart

import 'package:fish_redux/fish_redux.dart';

import 'infoHeader/state.dart';
import 'state.dart';

class HeaderInfoStateConn extends ConnOp<HouseDetailEditPageState, PublishInfoHeaderState>
    with ReselectMixin<HouseDetailEditPageState, PublishInfoHeaderState>{

  @override
  PublishInfoHeaderState computed(HouseDetailEditPageState pageState) {
    HouseDetailContentState state = pageState.detailPageState;
    return new PublishInfoHeaderState()
                ..title = state.title
                ..desc = state.desc
                ..cateId = pageState.cateId
                ..tags = state.tags;
  }

  @override
  List factors(HouseDetailEditPageState pageState) {
    //如果title、desc和tags没有变化，则不需要重新创建子state
    HouseDetailContentState state = pageState.detailPageState;
    return [
      state.title,
      state.desc,
      state.tags
    ];
  }
}
```

### Component之间的通信
主要用到Action、Effect和Reducer
1、Action用于创建动作  
2、Effect、Reducer注册Action对应的方法  
3、特殊情况  
如果当一个页面存在多个相同的Component时，这些Component都会注册对应的Action，此时发起一个Action时，所有Component都会得到Action进行响应，此时就必须要判断是否是对应的Component发起的。类似：
``` dart
PublishItemComponentState _refreshCurItem(PublishItemComponentState state, Action action) {
  PublishItemComponentState resultState = action.payload;
  if(state.moduleId == resultState.moduleId){
    final PublishItemComponentState newState = state.clone();
    return newState;
  }
  return state;
}

```
