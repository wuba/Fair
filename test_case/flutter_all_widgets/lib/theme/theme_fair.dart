import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairThemePage extends StatefulWidget {
  dynamic fairProps;

  FairThemePage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairThemePageState();
}

class _FairThemePageState extends State<FairThemePage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.red,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fair Sample'),
        ),
      ),
    );
  }
}
