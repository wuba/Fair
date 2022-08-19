
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Container'),),
      body: Column(
        children: [
          FlutterContainerPage(),
          FairWidget(
            path: 'assets/bundle/container/lib_container_container_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterContainerPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600],
        width: 48.0,
        height: 48.0,
      ),
    );
  }

}