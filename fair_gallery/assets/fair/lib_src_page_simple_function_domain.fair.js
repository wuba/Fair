GLOBAL['#FairKey#']=(function(__initProps__){const __global__=this;return runCallback(function(__mod__){with(__mod__.imports){function _FunctionDomainDemoState(){const inner=_FunctionDomainDemoState.__inner__;if(this==__global__){return new _FunctionDomainDemoState({__args__:arguments});}else{const args=arguments.length>0?arguments[0].__args__||arguments:[];inner.apply(this,args);_FunctionDomainDemoState.prototype.ctor.apply(this,args);return this;}}_FunctionDomainDemoState.__inner__=function inner(){this.fairProps=__initProps__;this._pageName='#FairKey#';this._supportCases=[];};_FunctionDomainDemoState.prototype={initState:function initState(){const __thiz__=this;with(__thiz__){fairProps=widget.fairProps;onLoad();}},_supportCaseTitle:function _supportCaseTitle(index,subIndex){const __thiz__=this;const __arg_ctx__={index,subIndex,};with(__thiz__){with(__arg_ctx__){let title=_supportCases.__op_idx__(index).__op_idx__(subIndex);return title;}}},_getRouteName:function _getRouteName(){const __thiz__=this;with(__thiz__){if(fairProps!=null&&fairProps.__op_idx__('routeName')!=null){return fairProps.__op_idx__('routeName');}return'';}},_onRefresh:function _onRefresh(input){const __thiz__=this;const __arg_ctx__={input,};with(__thiz__){with(__arg_ctx__){let futureId=input.__op_idx__('futureId');let argument=input.__op_idx__('argument');FairCommonPlugin().futureDelayed(convertObjectLiteralToSetOrMap({['pageName']:_pageName,['seconds']:2,['callback']:function dummy(result){FairCommonPlugin().futureComplete(convertObjectLiteralToSetOrMap({['pageName']:_pageName,['futureId']:futureId,['futureValue']:null,}));},}));}}},onLoad:function onLoad(){const __thiz__=this;with(__thiz__){_supportCases=[['typedef WidgetBuilder = Widget Function(BuildContext context)','package:flutter/src/widgets/framework.dart'],['typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index)','package:flutter/src/widgets/framework.dart'],['typedef NullableIndexedWidgetBuilder = Widget? Function(BuildContext context, int index)','package:flutter/src/widgets/framework.dart'],['typedef TransitionBuilder = Widget Function(BuildContext context, Widget? child)','package:flutter/src/widgets/framework.dart'],['typedef GenerateAppTitle = String Function(BuildContext context)','package:flutter/src/widgets/app.dart'],['typedef InputCounterWidgetBuilder = Widget? Function(BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused})','package:flutter/src/material/text_field.dart'],['typedef ToolbarBuilder = Widget Function(BuildContext context, Widget child)','package:flutter/src/widgets/text_selection.dart'],['typedef ReorderCallback = void Function(int oldIndex, int newIndex)','package:flutter/src/widgets/reorderable_list.dart'],['typedef ReorderItemProxyDecorator = Widget Function(Widget child, int index, Animation<double> animation)','package:flutter/src/widgets/reorderable_list.dart'],['typedef ExpansionPanelCallback = void Function(int panelIndex, bool isExpanded)','package:flutter/src/material/expansion_panel.dart'],['typedef ControlsWidgetBuilder = Widget Function(BuildContext context, ControlsDetails details)','package:flutter/src/material/stepper.dart'],['typedef PopupMenuItemBuilder<out T> = List<PopupMenuEntry<T>> Function(BuildContext context)','package:flutter/src/material/popup_menu.dart'],['typedef DropdownButtonBuilder = List<Widget> Function(BuildContext context)','package:flutter/src/material/dropdown.dart'],['typedef ExpansionPanelHeaderBuilder = Widget Function(BuildContext context, bool isExpanded)','package:flutter/src/material/expansion_panel.dart'],['typedef AnimatedCrossFadeBuilder = Widget Function(Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey)','package:flutter/src/widgets/animated_cross_fade.dart'],['typedef ValueWidgetBuilder<in T> = Widget Function(BuildContext context, T value, Widget? child)','package:flutter/src/widgets/value_listenable_builder.dart'],['typedef WillPopCallback = Future<bool> Function()','package:flutter/src/widgets/navigator.dart'],['typedef StatefulWidgetBuilder = Widget Function(BuildContext context, void Function(void Function()) setState)','package:flutter/src/widgets/basic.dart'],['typedef ImageFrameBuilder = Widget Function(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded)','package:flutter/src/widgets/image.dart'],['typedef ImageLoadingBuilder = Widget Function(BuildContext context, Widget child, ImageChunkEvent? loadingProgress)','package:flutter/src/widgets/image.dart'],['typedef ImageErrorWidgetBuilder = Widget Function(BuildContext context, Object error, StackTrace? stackTrace)','package:flutter/src/widgets/image.dart'],['typedef NestedScrollViewHeaderSliversBuilder = List<Widget> Function(BuildContext context, bool innerBoxIsScrolled)','package:flutter/src/widgets/nested_scroll_view.dart'],['typedef ChildIndexGetter = int? Function(Key key)','package:flutter/src/widgets/sliver.dart'],['typedef ScrollableWidgetBuilder = Widget Function(BuildContext context, ScrollController scrollController)','package:flutter/src/widgets/draggable_scrollable_sheet.dart'],['typedef LayoutWidgetBuilder = Widget Function(BuildContext context, BoxConstraints constraints)','package:flutter/src/widgets/layout_builder.dart'],['typedef OrientationWidgetBuilder = Widget Function(BuildContext context, Orientation orientation)','package:flutter/src/widgets/orientation_builder.dart'],['typedef AnimatedSwitcherTransitionBuilder = Widget Function(Widget child, Animation<double> animation)','package:flutter/src/widgets/animated_switcher.dart'],['typedef AnimatedSwitcherLayoutBuilder = Widget Function(Widget? currentChild, List<Widget> previousChildren)','package:flutter/src/widgets/animated_switcher.dart'],['typedef AnimatedTransitionBuilder = Widget Function(BuildContext context, Animation<double> animation, Widget? child)','package:flutter/src/widgets/dual_transition_builder.dart'],['typedef HeroFlightShuttleBuilder = Widget Function(BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext)','package:flutter/src/widgets/heroes.dart'],['typedef HeroPlaceholderBuilder = Widget Function(BuildContext context, Size heroSize, Widget child)','package:flutter/src/widgets/heroes.dart'],['typedef AnimatedListItemBuilder = Widget Function(BuildContext context, int index, Animation<double> animation)','package:flutter/src/widgets/animated_list.dart']];}},};_FunctionDomainDemoState.prototype.ctor=function(){};;return _FunctionDomainDemoState();}},[]);})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));