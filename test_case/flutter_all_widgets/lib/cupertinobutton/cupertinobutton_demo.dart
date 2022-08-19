
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoButtonDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterCupertinoButtonPage(),
          FairWidget(
            path:'assets/bundle/cupertinobutton/lib_cupertinobutton_cupertinobutton_widget.fair.json'
          )
        ],
      ),
    );
  }

}

class FlutterCupertinoButtonPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CupertinoButton(
            onPressed: null,
            child: Text('Disabled'),
          ),
          const SizedBox(height: 30),
          const CupertinoButton.filled(
            onPressed: null,
            child: Text('Disabled'),
          ),
          const SizedBox(height: 30),
          CupertinoButton(
            onPressed: () {},
            child: const Text('Enabled'),
          ),
          const SizedBox(height: 30),
          CupertinoButton.filled(
            onPressed: () {},
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }

}