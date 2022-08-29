import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSemanticsPage extends StatefulWidget {
  dynamic fairProps;

  FairSemanticsPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSemanticsPageState();
}

class _FairSemanticsPageState extends State<FairSemanticsPage> {
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
        child: Semantics(
      child: Text('Fair Sample'),
    ));
  }
}
