import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairCheckboxPage extends StatefulWidget {
  FairCheckboxPage({Key key, this.fairProps}) : super(key: key);

  dynamic fairProps;

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
  }

  Color _getColor(Set<MaterialState> states) {
    return Colors.red;
  }

  bool _isCheck() {
    return fairProps['isChecked'];
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: _isCheck(),
        checkColor: Colors.white,
//      fillColor: MaterialStateProperty.resolveWith(_getColor),
        activeColor: Colors.red,
        onChanged:_onChange,
      ),
    );
  }
}
