import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairCheckboxPage extends StatefulWidget {
  FairCheckboxPage({Key key, this.isChecked}) : super(key: key);

  dynamic fairProps;
  final String isChecked;

  @override
  State<StatefulWidget> createState() => _FairCheckboxState();
}

class _FairCheckboxState extends State<FairCheckboxPage> {
  @FairProps()
  var fairProps;

  bool _isChecked;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
    _isChecked = fairProps['isChecked'];
  }

  Color _getColor(Set<MaterialState> states) {
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: true,
        checkColor: Colors.white,
//      fillColor: MaterialStateProperty.resolveWith(_getColor),
        activeColor: Colors.red,
        onChanged: (value) => _isChecked = value,
      ),
    );
  }
}
