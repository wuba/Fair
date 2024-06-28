// ignore_for_file: unused_local_variable

import 'package:extended_sliver/extended_sliver.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

@FairPatch()
@FFRoute(
  name: 'fair://FunctionDomainDemo',
  routeName: 'Function 回调语法支持',
  description: 'Fair 支持的常用回调语法',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
    'group': '简单',
    'order': 3,
  },
)
class FunctionDomainDemo extends StatefulWidget {
  const FunctionDomainDemo({
    super.key,
    required this.fairProps,
  });

  final Map<String, dynamic> fairProps;

  @override
  State<FunctionDomainDemo> createState() => _FunctionDomainDemoState();
}

class _FunctionDomainDemoState extends State<FunctionDomainDemo> {
  @FairProps()
  var fairProps;
  final String _pageName = '#FairKey#';

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
    onLoad();
  }

  //var _supportCases = {};
  var _supportCases = [];

  String _supportCaseTitle(int index, int subIndex) {
    var title = _supportCases[index][subIndex];
    return title;
  }

  String _getRouteName() {
    if (fairProps != null && fairProps['routeName'] != null) {
      return fairProps['routeName'];
    }
    return '';
  }

  void _onRefresh(Map input) {
    String futureId = input['futureId'];
    // 可以传一些参数过去，多个参数用数组
    String argument = input['argument'];
    // 模拟一个耗时的操作，等操作完毕之后，再去完成 Future
    FairCommonPlugin().futureDelayed({
      // required
      'pageName': _pageName,
      'seconds': 2,
      'callback': (dynamic result) {
        FairCommonPlugin().futureComplete({
          // required
          'pageName': _pageName,
          'futureId': futureId,
          'futureValue': null,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Flutter 当中常用的回调域已经默认支持
      appBar: CommomAppBar(
        title: _getRouteName(),
        asset: Assets.assets_page_simple_function_domain_dart,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPinnedToBoxAdapter(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                color: Sugar.ifEqualBool(
                  innerBoxIsScrolled,
                  trueValue: () => Colors.red,
                  falseValue: () => Colors.blue,
                ),
                child: Text(
                  '作用域演示, innerBoxIsScrolled: $innerBoxIsScrolled',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () => Sugar.createFuture<void>(
            function: _onRefresh,
            argument: '可以传一些参数过去，多个参数用数组',
          ),
          child: DefaultTextStyle(
            style: const TextStyle(height: 1, color: Colors.black),
            child: CustomScrollView(slivers: [
              const SliverToBoxAdapter(
                  child: ListTile(
                title: Text(
                  'Fair当中支持的回调如下',
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text(
                    '三方支持请参考 \'fair_gallery/lib/src/utils/dynamic_widget_builder.dart\' 中的实现。'),
              )),
              const SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0.',
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '无入参回调，int,double,bool,String,Widget，以及它们的空类型和List类型，',
                          ),
                          SizedBox(height: 5),
                          Text(
                            '比如 int Function()',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(SugarString.concatenates(
                              SugarNum.numToString(SugarNum.adds(index, 1)),
                              '.')),
                          const SizedBox(width: 5),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HighlightView(
                                _supportCaseTitle(index, 0),
                                language: 'dart',
                                theme: SugarCommon.vsTheme(),
                                textStyle: const TextStyle(height: 1),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _supportCaseTitle(index, 1),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                  childCount: SugarList.length(_supportCases),
                ),
              ),
              const SliverToBoxAdapter(
                  child: ListTile(
                title: Text(
                  '多层作用域的演示',
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text('多层作用域，参数尽量不要写成相似的，FunctionDomain 的实现是字符串匹配'),
              )),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(SugarString.concatenates(
                                    SugarInt.intToString(index), '.')),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: Sugar.mapEach(
                                      SugarList.generate(
                                        SugarNum.toInt(SugarNum.adds(index, 1)),
                                        (p0) =>
                                            // 一定要用 asT
                                            // 不然会生成 'Color Function(int)' 无法找到映射
                                            //  'dynamic Function(int)':
                                            Sugar.asT<dynamic>(Color.fromARGB(
                                          255,
                                          SugarNum.toInt(SugarNum.multiplies(
                                            30,
                                            SugarNum.adds(
                                              index,
                                              1,
                                            ),
                                          )),
                                          SugarNum.toInt(SugarNum.multiplies(
                                            10,
                                            SugarNum.adds(
                                              p0,
                                              1,
                                            ),
                                          )),
                                          SugarNum.toInt(SugarNum.multiplies(
                                            10,
                                            SugarNum.adds(
                                              SugarNum.adds(index, p0),
                                              1,
                                            ),
                                          )),
                                        )),
                                      ),
                                      (mapIndex, dynamic item) {
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          color: item,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '$mapIndex',
                                            style: TextStyle(
                                              color:
                                                  SugarCommon.getLuminanceColor(
                                                SugarCommon
                                                    .colorComputeLuminance(
                                                  item,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void onLoad() {
    _supportCases = [
      [
        'typedef WidgetBuilder = Widget Function(BuildContext context)',
        'package:flutter/src/widgets/framework.dart'
      ],
      [
        'typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index)',
        'package:flutter/src/widgets/framework.dart'
      ],
      [
        'typedef NullableIndexedWidgetBuilder = Widget? Function(BuildContext context, int index)',
        'package:flutter/src/widgets/framework.dart'
      ],
      [
        'typedef TransitionBuilder = Widget Function(BuildContext context, Widget? child)',
        'package:flutter/src/widgets/framework.dart'
      ],
      [
        'typedef GenerateAppTitle = String Function(BuildContext context)',
        'package:flutter/src/widgets/app.dart',
      ],
      [
        'typedef InputCounterWidgetBuilder = Widget? Function(BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused})',
        'package:flutter/src/material/text_field.dart',
      ],
      [
        'typedef ToolbarBuilder = Widget Function(BuildContext context, Widget child)',
        'package:flutter/src/widgets/text_selection.dart',
      ],
      [
        'typedef ReorderCallback = void Function(int oldIndex, int newIndex)',
        'package:flutter/src/widgets/reorderable_list.dart',
      ],
      [
        'typedef ReorderItemProxyDecorator = Widget Function(Widget child, int index, Animation<double> animation)',
        'package:flutter/src/widgets/reorderable_list.dart',
      ],
      [
        'typedef ExpansionPanelCallback = void Function(int panelIndex, bool isExpanded)',
        'package:flutter/src/material/expansion_panel.dart',
      ],
      [
        'typedef ControlsWidgetBuilder = Widget Function(BuildContext context, ControlsDetails details)',
        'package:flutter/src/material/stepper.dart',
      ],
      [
        'typedef PopupMenuItemBuilder<out T> = List<PopupMenuEntry<T>> Function(BuildContext context)',
        'package:flutter/src/material/popup_menu.dart',
      ],
      [
        'typedef DropdownButtonBuilder = List<Widget> Function(BuildContext context)',
        'package:flutter/src/material/dropdown.dart',
      ],
      [
        'typedef ExpansionPanelHeaderBuilder = Widget Function(BuildContext context, bool isExpanded)',
        'package:flutter/src/material/expansion_panel.dart',
      ],
      [
        'typedef AnimatedCrossFadeBuilder = Widget Function(Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey)',
        'package:flutter/src/widgets/animated_cross_fade.dart',
      ],
      [
        'typedef ValueWidgetBuilder<in T> = Widget Function(BuildContext context, T value, Widget? child)',
        'package:flutter/src/widgets/value_listenable_builder.dart',
      ],
      [
        'typedef WillPopCallback = Future<bool> Function()',
        'package:flutter/src/widgets/navigator.dart',
      ],
      [
        'typedef StatefulWidgetBuilder = Widget Function(BuildContext context, void Function(void Function()) setState)',
        'package:flutter/src/widgets/basic.dart',
      ],
      [
        'typedef ImageFrameBuilder = Widget Function(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded)',
        'package:flutter/src/widgets/image.dart',
      ],
      [
        'typedef ImageLoadingBuilder = Widget Function(BuildContext context, Widget child, ImageChunkEvent? loadingProgress)',
        'package:flutter/src/widgets/image.dart',
      ],
      [
        'typedef ImageErrorWidgetBuilder = Widget Function(BuildContext context, Object error, StackTrace? stackTrace)',
        'package:flutter/src/widgets/image.dart',
      ],
      [
        'typedef NestedScrollViewHeaderSliversBuilder = List<Widget> Function(BuildContext context, bool innerBoxIsScrolled)',
        'package:flutter/src/widgets/nested_scroll_view.dart',
      ],
      [
        'typedef ChildIndexGetter = int? Function(Key key)',
        'package:flutter/src/widgets/sliver.dart',
      ],
      [
        'typedef ScrollableWidgetBuilder = Widget Function(BuildContext context, ScrollController scrollController)',
        'package:flutter/src/widgets/draggable_scrollable_sheet.dart',
      ],
      [
        'typedef LayoutWidgetBuilder = Widget Function(BuildContext context, BoxConstraints constraints)',
        'package:flutter/src/widgets/layout_builder.dart',
      ],
      [
        'typedef OrientationWidgetBuilder = Widget Function(BuildContext context, Orientation orientation)',
        'package:flutter/src/widgets/orientation_builder.dart',
      ],
      [
        'typedef AnimatedSwitcherTransitionBuilder = Widget Function(Widget child, Animation<double> animation)',
        'package:flutter/src/widgets/animated_switcher.dart',
      ],
      [
        'typedef AnimatedSwitcherLayoutBuilder = Widget Function(Widget? currentChild, List<Widget> previousChildren)',
        'package:flutter/src/widgets/animated_switcher.dart',
      ],
      [
        'typedef AnimatedTransitionBuilder = Widget Function(BuildContext context, Animation<double> animation, Widget? child)',
        'package:flutter/src/widgets/dual_transition_builder.dart',
      ],
      [
        'typedef HeroFlightShuttleBuilder = Widget Function(BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext)',
        'package:flutter/src/widgets/heroes.dart',
      ],
      [
        'typedef HeroPlaceholderBuilder = Widget Function(BuildContext context, Size heroSize, Widget child)',
        'package:flutter/src/widgets/heroes.dart',
      ],
      [
        'typedef AnimatedListItemBuilder = Widget Function(BuildContext context, int index, Animation<double> animation)',
        'package:flutter/src/widgets/animated_list.dart',
      ],
    ];
  }
}
