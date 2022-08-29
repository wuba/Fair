import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliderDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RowDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Slider(
              value: _sliderValue,
              onChanged: (v) {
                setState(() {
                  _sliderValue = v;
                });
              },
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/slider/lib_slider_slider_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
