import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTextButtonPage extends StatefulWidget {
  dynamic fairProps;

  FairTextButtonPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTextButtonPageState();
}

class _FairTextButtonPageState extends State<FairTextButtonPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String _getContent() => fairProps['content'];

  _onPressed() => print('click text button');

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: Text(_getContent()),
    );
  }
}
