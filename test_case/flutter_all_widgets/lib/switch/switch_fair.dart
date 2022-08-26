import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSwitchPage extends StatefulWidget {
  dynamic fairProps;

  FairSwitchPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSwitchPageState();
}

class _FairSwitchPageState extends State<FairSwitchPage> {
  @FairProps()
  var fairProps;

  var _switchValue = false;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  _onChanged(v) {
    setState(() {
      _switchValue = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Switch(
      value: _switchValue,
      onChanged: _onChanged,
    ));
  }
}
