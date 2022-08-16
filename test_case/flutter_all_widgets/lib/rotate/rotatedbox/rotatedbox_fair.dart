import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairRotatedBoxPage extends StatefulWidget {
  dynamic fairProps;

  FairRotatedBoxPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairRotatedBoxPageState();
}

class _FairRotatedBoxPageState extends State<FairRotatedBoxPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  int _getTurns() => fairProps['quarterTurns'];

  Widget _getChild() => Container(
        color: Colors.green,
        child: Text("Hello world"),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RotatedBox(
      quarterTurns: _getTurns(), //旋转90度(1/4圈)
      child: _getChild(),
    ));
  }
}
