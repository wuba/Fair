import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairScrollbarPage extends StatefulWidget {
  dynamic fairProps;

  FairScrollbarPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairScrollbarPageState();
}

class _FairScrollbarPageState extends State<FairScrollbarPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  Widget _getChild() => ListView.builder(
        reverse: false,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              height: 45,
              alignment: Alignment.center,
              child: Text('$index'),
            ),
          );
        },
        itemCount: 30,
        itemExtent: 50,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scrollbar(
      child: _getChild(),
    ));
  }
}
