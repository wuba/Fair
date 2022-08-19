import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTextFieldPage extends StatefulWidget {
  dynamic fairProps;

  FairTextFieldPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTextFieldPageState();
}

class _FairTextFieldPageState extends State<FairTextFieldPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return TextField();
  }
}
