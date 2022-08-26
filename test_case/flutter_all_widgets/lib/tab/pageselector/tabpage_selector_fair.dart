import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTabPageSelectorPage extends StatefulWidget {
  dynamic fairProps;

  FairTabPageSelectorPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTabPageSelectorPageState();
}

class _FairTabPageSelectorPageState extends State<FairTabPageSelectorPage> {
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
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.blue,
          alignment: Alignment.center,
          child: TabPageSelector(
            controller: _controller,
            color: Colors.white,
            selectedColor: Colors.red,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
