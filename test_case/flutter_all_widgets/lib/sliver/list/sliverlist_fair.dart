import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverListPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverListPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliverListPageState();
}

class _FairSliverListPageState extends State<FairSliverListPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  SliverChildDelegate _getDelegate() {
    return SliverChildBuilderDelegate(
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: _getDelegate(),
        ),
      ],
    );
  }
}
