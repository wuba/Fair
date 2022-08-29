import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTooltipPage extends StatefulWidget {
  dynamic fairProps;

  FairTooltipPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTooltipPageState();
}

class _FairTooltipPageState extends State<FairTooltipPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Fair Sample',
      child: Icon(Icons.book_online),
    );
  }
}
