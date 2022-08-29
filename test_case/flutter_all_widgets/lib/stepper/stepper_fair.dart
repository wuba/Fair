import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairStepperPage extends StatefulWidget {
  dynamic fairProps;

  FairStepperPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairStepperPageState();
}

class _FairStepperPageState extends State<FairStepperPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        steps: <Step>[
          Step(title: Text('Fair一期'), content: Text('2020')),
          Step(title: Text('Fair二期'), content: Text('2021')),
          Step(title: Text('Fair三期'), content: Text('2022')),
        ],
      ),
    );
  }
}
