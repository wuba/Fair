import 'dart:async';
import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  StreamController<String> _streamController;

  @override
  void initState() {
    _streamController = StreamController<String>();
    _streamController.add("Fair Sample");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilderDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                }
                return Text('未收到数据');
              },
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/streambuilder/lib_streambuilder_streambuilder_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
