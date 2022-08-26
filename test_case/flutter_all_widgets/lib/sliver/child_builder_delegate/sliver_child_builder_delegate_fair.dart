import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverChildBuilderDelegatePage extends StatefulWidget {
  dynamic fairProps;

  FairSliverChildBuilderDelegatePage({Key key, this.fairProps})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FairSliverChildBuilderDelegatePageState();
}

class _FairSliverChildBuilderDelegatePageState
    extends State<FairSliverChildBuilderDelegatePage> {
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
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: _getDelegate(),
        ),
      ],
    );
  }
}
