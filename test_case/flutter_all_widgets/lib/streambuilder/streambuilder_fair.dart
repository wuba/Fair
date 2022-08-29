import 'dart:async';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairStreamBuilderPage extends StatefulWidget {
  dynamic fairProps;

  FairStreamBuilderPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairStreamBuilderPageState();
}

class _FairStreamBuilderPageState extends State<FairStreamBuilderPage> {
  @FairProps()
  var fairProps;

  StreamController<String> _streamController;

  @override
  void initState() {
    _streamController = StreamController<String>();
    _streamController.add("Fair Sample");
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data);
        }
        return Text('未收到数据');
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
