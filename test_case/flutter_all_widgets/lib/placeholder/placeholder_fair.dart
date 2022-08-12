import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairPlaceholderPage extends StatefulWidget {
  dynamic fairProps;

  FairPlaceholderPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairPlaceholderPageState();
}

class _FairPlaceholderPageState extends State<FairPlaceholderPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  Color _getColor() => Color(int.parse(fairProps['color']));

  double _getStrokeWidth() => double.parse(fairProps['strokeWidth']);

  double _getFallbackWidth() => double.parse(fairProps['fallbackWidth']);

  double _getFallbackHeight() => double.parse(fairProps['fallbackHeight']);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Placeholder(
    ));
  }
}
