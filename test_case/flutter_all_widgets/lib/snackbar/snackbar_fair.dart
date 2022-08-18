import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSnackBarPage extends StatefulWidget {
  dynamic fairProps;

  FairSnackBarPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSnackBarPageState();
}

class _FairSnackBarPageState extends State<FairSnackBarPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String _getContent() => fairProps['content'] ?? 'Fair Sample';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_getContent()),
        ));
      },
      child: Text('Click To Show SnackBar'),
    ));
  }
}
