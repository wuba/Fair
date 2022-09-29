
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairConstrainedBoxPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairConstrainedBoxPageState();

}

class _FairConstrainedBoxPageState extends State<FairConstrainedBoxPage>{
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 60, maxWidth: 200),
      child: Container(height: 300, width: 300, color: Colors.red),
    );
  }

}