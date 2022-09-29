import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairRowPage extends StatefulWidget {
  dynamic fairProps;

  FairRowPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairRowPageState();
}

class _FairRowPageState extends State<FairRowPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Text('Fair Sample 1'),
        Text('Fair Sample 2'),
      ],
    ));
  }
}
