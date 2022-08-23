import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSingleChildScrollViewPage extends StatefulWidget {
  dynamic fairProps;

  FairSingleChildScrollViewPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSingleChildScrollViewPageState();
}

class _FairSingleChildScrollViewPageState
    extends State<FairSingleChildScrollViewPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  Widget _getChild() {
    return Column(
      children: List.generate(
          50,
          (index) => Container(
                height: 150,
                color: Colors.primaries[index % Colors.primaries.length],
              )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: _getChild(),
    ));
  }
}
