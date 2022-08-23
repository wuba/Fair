import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTextPage extends StatefulWidget {
  dynamic fairProps;

  FairTextPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTextPageState();
}

class _FairTextPageState extends State<FairTextPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String _getContent() {
    return fairProps['content'];
  }

  @override
  Widget build(BuildContext context) {
    return Text(_getContent());
  }
}
