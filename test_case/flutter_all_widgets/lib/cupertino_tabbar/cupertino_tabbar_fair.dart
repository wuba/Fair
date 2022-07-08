
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



@FairPatch()
class FairCupertinoTabBarPage extends StatefulWidget {
  dynamic fairProps;

  FairCupertinoTabBarPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairCupertinoTabBarState();
}

class _FairCupertinoTabBarState extends State<FairCupertinoTabBarPage> {
  @FairProps()
  var fairProps;

  List<String> tabs;

  @override
  void initState() {
    super.initState();
    print('baixue:initState');
    fairProps = widget.fairProps;
  }

  List<String> _getTabList() {
    print('baixue:${fairProps['tabList']}');
    return fairProps['tabList'];
  }

  /**
   * 问题1：
   * CupertinoTabBar的item中，调用此方法
   *
   * type 'WarningWidget' is not a subtype of type 'List<dynamic>?'
   *
   * 可能解析时出错了，默认返回了WarningWidget,使用list.map((e)=> widget)效果一样
   */
  List<BottomNavigationBarItem> _getTableItem() {
    print('_getTableItem');
    return Sugar.mapEach(
        _getTabList(),
            (index, item) => BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), label: item)).toList();
  }

  CupertinoTabBar _getTabBarWidget() {
    print('_getTabBarWidget');
    print(fairProps['tabList']);
    return CupertinoTabBar(
      items:  _getTableItem(),
    );
  }

  /**
   * 问题2：
   * ([dynamic]) => dynamic' is not a subtype of type '(BuildContext, int) => Widget'
   */
  Widget _getTabBuild(BuildContext context, int index) {
    return CupertinoTabView(
      builder: (BuildContext context) => Center(
        child: Text('Page of tab $index'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.blueAccent,
      tabBar: _getTabBarWidget(),
      tabBuilder: _getTabBuild,
    );
  }
}
