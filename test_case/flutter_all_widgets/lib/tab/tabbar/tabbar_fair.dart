import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTabBarPage extends StatefulWidget {
  dynamic fairProps;

  FairTabBarPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTabBarPageState();
}

class _FairTabBarPageState extends State<FairTabBarPage> {
  @FairProps()
  var fairProps;

  final List<String> _tabValues = [
    'Fair 一期',
    'Fair 二期',
    'Fair 三期',
  ];

  TabController _controller;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;

    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBarDemo'),
        bottom: TabBar(
          tabs: _tabValues.map((f) {
            return Text(f);
          }).toList(),
          controller: _controller,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicatorWeight: 5.0,
          labelStyle: TextStyle(height: 2),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _tabValues.map((f) {
          return Center(
            child: Text(f),
          );
        }).toList(),
      ),
    );
  }
}
