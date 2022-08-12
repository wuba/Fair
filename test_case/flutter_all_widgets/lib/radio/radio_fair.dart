import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairRadioPage extends StatefulWidget {
  dynamic fairProps;

  FairRadioPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairRadioPageState();
}

class _FairRadioPageState extends State<FairRadioPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  _onChanged(value) {
    print('$value');
  }

  _getValue() => fairProps['value'];

  _getGroupValue() => fairProps['groupValue'];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Radio(
      value: _getValue(),
      groupValue: _getGroupValue(),
      onChanged: _onChanged,
    ));
  }
}
