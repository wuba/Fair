import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairRawKeyboardListenerPage extends StatefulWidget {
  dynamic fairProps;

  FairRawKeyboardListenerPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairRawKeyboardListenerPageState();
}

class _FairRawKeyboardListenerPageState
    extends State<FairRawKeyboardListenerPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  _handleKey(key) {
    print('key label:${key.data.keyLabel}');
  }

  FocusNode _getNode() {
    return FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: _getNode(),
        onKey: _handleKey,
        child: Container(
          color: Colors.blue,
        ));
  }
}
