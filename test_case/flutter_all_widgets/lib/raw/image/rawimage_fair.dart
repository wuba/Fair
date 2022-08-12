import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairRawImagePage extends StatefulWidget {
  dynamic fairProps;

  FairRawImagePage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairRawImagePageState();
}

class _FairRawImagePageState extends State<FairRawImagePage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: RawImage());
  }
}
