import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairScaffoldPage extends StatefulWidget {
  dynamic fairProps;

  FairScaffoldPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairScaffoldPageState();
}

class _FairScaffoldPageState extends State<FairScaffoldPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('fair'),
      ),
    );
  }
}
