

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairChipPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairChipPageState();

}

class _FairChipPageState extends State<FairChipPage>{
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: const Text('Fair'),
      ),
      label: const Text('Aaron Burr'),
    );
  }

}