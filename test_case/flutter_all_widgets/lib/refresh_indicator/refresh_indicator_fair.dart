import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairRefreshIndicatorPage extends StatefulWidget {
  dynamic fairProps;

  FairRefreshIndicatorPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairRefreshIndicatorPageState();
}

class _FairRefreshIndicatorPageState extends State<FairRefreshIndicatorPage> {
  @FairProps()
  var fairProps;

  var _list = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  _onRefresh() async {
    setState(() {
      _list.add(_list.length + 1);
    });
  }

  Widget _getChild() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('fair ${_list[index]}'),
        );
      },
      itemExtent: 50,
      itemCount: _list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: _getChild(),
    ));
  }
}
