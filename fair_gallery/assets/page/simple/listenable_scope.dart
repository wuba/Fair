import 'package:extended_tabs/extended_tabs.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:fair_gallery/src/widget/listenable_scope.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';

@FairPatch()
@FFRoute(
  name: 'fair://ListenableScopeDemo',
  routeName: 'js 访问 Flutter 中对象的例子',
  description:
      '如何在 Fair 中使用 ScrollController, AnimationController, TabController, ValueNotifier',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
    'group': '简单',
    'order': 4,
  },
)
class ListenableScopeDemo extends StatefulWidget {
  const ListenableScopeDemo({super.key});

  @override
  State<ListenableScopeDemo> createState() => _ListenableScopeDemoState();
}

class _ListenableScopeDemoState extends State<ListenableScopeDemo> {
  @FairProps()
  var fairProps;
  final String _pageName = '#FairKey#';

  // 用于去内存里面获取 ListenableScope
  String _uniqueKey = '';

  String _getRouteName() {
    if (fairProps != null && fairProps['routeName'] != null) {
      return fairProps['routeName'];
    }
    return '';
  }

  void _onCreateKey(String key) {
    _uniqueKey = key;
  }

  void _addListener(dynamic value) {
    var type = value[0];
    var values = value[1];

    FairCommonPlugin().jsPrint(
      {
        'pageName': _pageName,
        'type': type,
        'values': values,
      },
    );
  }

  void _onTabControllerSetIndex(int index) {
    FairCommonPlugin().tabController({
      'pageName': _pageName,
      'uniqueKey': _uniqueKey,
      'type': 'TabController0',
      'method': 'set',
      'parameter': index,
    });
  }

  void _onTabControllerAnimateTo(int index) {
    FairCommonPlugin().tabController({
      'pageName': _pageName,
      'uniqueKey': _uniqueKey,
      'type': 'TabController0',
      'method': 'animateTo',
      'parameter': index,
    });
  }

  void _onScrollControllerAnimateTo(double offset) {
    FairCommonPlugin().scrollController({
      'pageName': _pageName,
      'uniqueKey': _uniqueKey,
      'type': 'ScrollController',
      'method': 'get',
      'callback': (values) {
        if (values['hasClients'] == true) {
          FairCommonPlugin().scrollController({
            'pageName': _pageName,
            'uniqueKey': _uniqueKey,
            'type': 'ScrollController',
            'method': 'animateTo',
            'parameter': {
              'offset': offset,
              'duration': const Duration(seconds: 1),
              'curve': 'Curves.bounceIn',
            },
          });
        }
      }
    });
  }

  void _onValueNotifierSetValue(double value) {
    FairCommonPlugin().valueNotifier({
      'pageName': _pageName,
      'uniqueKey': _uniqueKey,
      'type': 'ValueNotifier',
      'method': 'set',
      'parameter': value,
    });
  }

  void _onAnimationControllerStart() {
    FairCommonPlugin().animationController({
      'pageName': _pageName,
      'uniqueKey': _uniqueKey,
      'type': 'AnimationController',
      'method': 'get',
      'callback': (values) {
        if (values['isAnimating'] == true) {
          return;
        }
        var method = 'forward';
        if (values['isCompleted'] == true) {
          method = 'reverse';
        }
        FairCommonPlugin().animationController({
          'pageName': _pageName,
          'uniqueKey': _uniqueKey,
          'type': 'AnimationController',
          'method': method,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommomAppBar(
        title: _getRouteName(),
        asset: Assets.assets_page_simple_listenable_scope_dart,
      ),
      body: ListenableScope(
        addListener: _addListener,
        onCreateKey: _onCreateKey,
        uniqueKey: 'ListenableScopeDemo',
        configs: [
          ListenableScopeConfig(type: 'ScrollController'),
          ListenableScopeConfig(
            type: 'AnimationController',
            addListener: true,
          ),
          // 有重复的类型，请用 tag 区分
          ListenableScopeConfig(
            type: 'TabController',
            addListener: true,
            tag: '0',
          ),
          ListenableScopeConfig(
            type: 'ValueNotifier',
            addListener: true,
          ),
          // 有重复的类型，请用 tag 区分
          ListenableScopeConfig(
            type: 'TabController',
            tag: '1',
          ),
        ],
        onCreate: (String key, TickerProvider vsync) {
          return Sugar.switchCase(
            key,
            [
              SugarSwitchCaseObj(
                sugarCase: () => 'ScrollController',
                reValue: () => ScrollController(),
              ),
              SugarSwitchCaseObj(
                sugarCase: () => 'AnimationController',
                reValue: () => AnimationController(
                  vsync: vsync,
                  value: 50.0,
                  lowerBound: 50.0,
                  upperBound: 100.0,
                  duration: const Duration(seconds: 2),
                  reverseDuration: const Duration(seconds: 2),
                ),
              ),
              SugarSwitchCaseObj(
                sugarCase: () => 'TabController0',
                reValue: () => TabController(vsync: vsync, length: 2),
              ),
              SugarSwitchCaseObj(
                sugarCase: () => 'ValueNotifier',
                reValue: () => ValueNotifier(1.0),
              ),
              SugarSwitchCaseObj(
                sugarCase: () => 'TabController1',
                reValue: () => TabController(vsync: vsync, length: 3),
              ),
            ],
            () => Sugar.nullValue(),
          );
        },
        builder: (BuildContext context) {
          return Column(
            children: [
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: SugarCommon.voidCallBack(
                      function: _onTabControllerSetIndex,
                      value: 1,
                    ),
                    child: const Text('设置 TabController index'),
                  ),
                  TextButton(
                    onPressed: SugarCommon.voidCallBack(
                      function: _onTabControllerAnimateTo,
                      value: 1,
                    ),
                    child: const Text('调用 TabController animateTo'),
                  ),
                  TextButton(
                    onPressed: SugarCommon.voidCallBack(
                      function: _onScrollControllerAnimateTo,
                      value: 300.0,
                    ),
                    child: const Text('调用 ScrollController animateTo'),
                  ),
                  TextButton(
                    onPressed: SugarCommon.voidCallBack(
                      function: _onValueNotifierSetValue,
                      value: 666.0,
                    ),
                    child: const Text('设置 ValueNotifier 的值'),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: ListenableScope.of<ValueNotifier>(
                  context,
                  'ValueNotifier',
                ),
                builder: (context, dynamic value, child) {
                  return Text(
                    SugarString.concatenates(
                      'ValueNotifier 的值为:',
                      '$value',
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: _onAnimationControllerStart,
                child: Center(
                  child: AnimatedBuilder(
                    animation: ListenableScope.of<AnimationController>(
                      context,
                      'AnimationController',
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: 50,
                        width: Sugar.mapGet(
                          Sugar.dartObjectToMap(
                            ListenableScope.of<AnimationController>(
                              context,
                              'AnimationController',
                            ),
                          ),
                          'value',
                        ),
                        color: Colors.blue,
                        child: const Text(
                          '点我开始动画!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              TabBar(
                tabs: const [
                  Tab(
                    child: Text(
                      'Tab0',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Tab1',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
                controller: ListenableScope.of<TabController>(
                  context,
                  'TabController0',
                ),
              ),
              Expanded(
                child: ExtendedTabBarView(
                  controller: ListenableScope.of<TabController>(
                    context,
                    'TabController0',
                  ),
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Tab0',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemExtent: 60,
                            controller: ListenableScope.of<ScrollController>(
                              context,
                              'ScrollController',
                            ),
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text('$index'),
                              );
                            },
                            itemCount: 100,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(
                              child: Text(
                                'Tab10',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Tab11',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Tab12',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                          controller: ListenableScope.of<TabController>(
                            context,
                            'TabController1',
                          ),
                        ),
                        Expanded(
                          child: ExtendedTabBarView(
                            controller: ListenableScope.of<TabController>(
                              context,
                              'TabController1',
                            ),
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Tab10',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.green,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Tab11',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.yellow,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Tab12',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
