import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairScrollablePage extends StatefulWidget {
  dynamic fairProps;

  FairScrollablePage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairScrollablePageState();
}

class _FairScrollablePageState extends State<FairScrollablePage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  Widget _getBuilder(context, position) {
    return ListView(
      children: <Widget>[
        Text('fair1'),
        Text('fair2'),
        Text('fair3'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Scrollable(viewportBuilder: _getBuilder));
  }
}
