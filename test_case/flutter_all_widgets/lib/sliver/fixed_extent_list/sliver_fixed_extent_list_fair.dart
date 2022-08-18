import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverFixedExtentListPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverFixedExtentListPage({Key key, this.fairProps})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FairSliverFixedExtentListPageState();
}

class _FairSliverFixedExtentListPageState
    extends State<FairSliverFixedExtentListPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  SliverChildDelegate _getDelegate() => SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Card(
            child: Container(
              alignment: Alignment.center,
              color: Colors.primaries[(index % 18)],
              child: Text(''),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: _getDelegate(),
        ),
      ],
    );
  }
}
