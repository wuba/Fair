
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';


@FairPatch()
class FairAppBarPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_FairAppBarPageState();

}

class _FairAppBarPageState extends State<FairAppBarPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fair Appbar'),
      ),
      body: Center(
        child: Text('This is the fair page',style: TextStyle(fontSize:24 )),
      ),
    );
  }

}