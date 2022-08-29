import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTransformPage extends StatefulWidget {
  dynamic fairProps;

  FairTransformPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTransformPageState();
}

class _FairTransformPageState extends State<FairTransformPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationZ(0.5),
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
      ),
    );
  }
}
