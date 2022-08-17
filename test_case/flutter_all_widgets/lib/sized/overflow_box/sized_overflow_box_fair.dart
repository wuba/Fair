import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSizedOverflowBoxPage extends StatefulWidget {
  dynamic fairProps;

  FairSizedOverflowBoxPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSizedOverflowBoxPageState();
}

class _FairSizedOverflowBoxPageState extends State<FairSizedOverflowBoxPage> {
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
      color: Colors.blue[50],
      child: SizedOverflowBox(
        size: const Size(100.0, 100.0),
        alignment: AlignmentDirectional.bottomStart,
        child: Container(
          height: 50.0,
          width: 150.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
