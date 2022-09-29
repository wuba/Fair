
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ChipDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chip'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterChipPage(),
          FairWidget(
            path: 'assets/bundle/chip/lib_chip_chip_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterChipPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: const Text('Flutter'),
      ),
      label: const Text(' Aaron Burr'),
    );
  }

}