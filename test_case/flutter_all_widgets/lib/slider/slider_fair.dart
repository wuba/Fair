import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliderPage extends StatefulWidget {
  dynamic fairProps;

  FairSliderPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliderPageState();
}

class _FairSliderPageState extends State<FairSliderPage> {
  @FairProps()
  var fairProps;

  double _sliderValue = 0;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  _onChanged(v) {
    setState(() {
      _sliderValue = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Slider(
      value: _sliderValue,
      onChanged: _onChanged,
    ));
  }
}
