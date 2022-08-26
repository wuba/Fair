import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSizedBoxPage extends StatefulWidget {
  dynamic fairProps;

  FairSizedBoxPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSizedBoxPageState();
}

class _FairSizedBoxPageState extends State<FairSizedBoxPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  double _getHeight() {
    return fairProps['height'];
  }

  double _getWidth() {
    return fairProps['width'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      height: _getHeight(),
      width: _getWidth(),
      child: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text('Fair Sample'),
      ),
    ));
  }
}
