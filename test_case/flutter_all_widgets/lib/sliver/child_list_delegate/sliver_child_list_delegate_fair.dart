import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverChildListDelegatePage extends StatefulWidget {
  dynamic fairProps;

  FairSliverChildListDelegatePage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FairSliverChildListDelegatePageState();
}

class _FairSliverChildListDelegatePageState
    extends State<FairSliverChildListDelegatePage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  List<Widget> _getChildren() {
    final result = <Widget>[];
    for (int i = 0; i < 10; i++) {
      result.add(Card(
        child: Container(
          alignment: Alignment.center,
          color: Colors.primaries[(i % 18)],
          child: Text(''),
        ),
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(_getChildren()),
        ),
      ],
    );
  }
}
