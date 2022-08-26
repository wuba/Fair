import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class StepperDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StepperDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              steps: <Step>[
                Step(title: Text('Fair一期'), content: Text('2020')),
                Step(title: Text('Fair二期'), content: Text('2021')),
                Step(title: Text('Fair三期'), content: Text('2022')),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/stepper/lib_stepper_stepper_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
