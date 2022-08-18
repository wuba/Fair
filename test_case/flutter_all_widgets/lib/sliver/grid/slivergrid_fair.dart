import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverGridPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverGridPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliverGridPageState();
}

class _FairSliverGridPageState extends State<FairSliverGridPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  SliverGridDelegate _getGridDelegate() =>
      SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3);

  SliverChildDelegate _getDelegate() =>
      SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
        );
      }, childCount: 20);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: _getGridDelegate(),
          delegate: _getDelegate(),
        ),
      ],
    );
  }
}
