import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairStackPage extends StatefulWidget {
  dynamic fairProps;

  FairStackPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairStackPageState();
}

class _FairStackPageState extends State<FairStackPage> {
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
        child: Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Container(
          height: 170,
          width: 170,
          color: Colors.blue,
        ),
        Container(
          height: 140,
          width: 140,
          color: Colors.yellow,
        )
      ],
    ));
  }
}
