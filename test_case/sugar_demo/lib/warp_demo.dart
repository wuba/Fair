
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';


@FairPatch()
class WrapDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_WrapState();

}

class _WrapState extends State<WrapDemo>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(),
     body: Wrap(
       spacing: 8.0, // gap between adjacent chips
       runSpacing: 4.0, // gap between lines
       children: <Widget>[
         Chip(
           avatar: CircleAvatar(backgroundColor: Sugar.colorsShade(Colors.blue, 900) , child: const Text('AH')),
           label: const Text('Hamilton'),
         ),
         Chip(
           avatar: CircleAvatar(backgroundColor: Sugar.colorsWithOpacity(Colors.blue,  0.9), child: const Text('ML')),
           label: const Text('Lafayette'),
         ),
         Chip(
           avatar: CircleAvatar(backgroundColor: Sugar.colorsWithOpacity(Colors.blue,  0.9), child: const Text('HM')),
           label: const Text('Mulligan'),
         ),
         Chip(
           avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('LP')),
           label: const Text('Laurens'),
         ),
       ],
     ),
   );
  }

}