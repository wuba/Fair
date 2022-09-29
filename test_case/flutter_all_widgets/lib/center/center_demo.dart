
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class CenterDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Center'),
      ),
      body: Column(
        children: [
          Expanded(child: Center(child: Text('Flutter Center'),)),
          Expanded(child: FairWidget(path: 'assets/bundle/center/lib_center_center_demo.fair.json',)),
        ],
      ),
    );
  }

}

@FairPatch()
class FairCenterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairCenterPageState();

}

class _FairCenterPageState extends State<FairCenterPage>{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Fair Center'),);
  }

}
