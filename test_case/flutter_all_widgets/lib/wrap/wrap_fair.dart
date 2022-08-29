import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairWrapPage extends StatefulWidget {
  dynamic fairProps;

  FairWrapPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairWrapPageState();
}

class _FairWrapPageState extends State<FairWrapPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(10, (i) {
        double w = 50.0 + 10 * i;
        return Container(
          color: Colors.primaries[i],
          height: 50,
          width: w,
          child: Text('$i'),
        );
      }),
    );
  }
}
