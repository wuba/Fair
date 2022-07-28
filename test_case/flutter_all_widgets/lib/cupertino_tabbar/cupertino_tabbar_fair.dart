
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/**
 * type 'WarningWidget' is not a subtype of type 'List<dynamic>?'
 */
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
    fairProps = widget.fairProps;
  }

  List<String> _getTabList() {
    return fairProps['tabList'];
  }

  List<BottomNavigationBarItem> _getTableItem() {
    return Sugar.mapEach(
        _getTabList(),
            (index, item) => BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), label: item)).toList();
  }

  CupertinoTabBar _getTabBarWidget() {
    return CupertinoTabBar(
      items: _getTableItem(),
    );
  }


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
      backgroundColor: Colors.blue,
      tabBar: _getTabBarWidget(),
      tabBuilder: _getTabBuild,
    );
  }
}
