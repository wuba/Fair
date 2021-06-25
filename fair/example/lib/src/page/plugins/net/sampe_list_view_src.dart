import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_example/src/fair_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'sample_list_part.dart';

class SampleWanAndroidPageSrc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SampleWanAndroidPageSrcState();
}

class SampleWanAndroidPageSrcState extends State<SampleWanAndroidPageSrc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[0],
                child: Column(
                  children: [
                    Text(
                      '用户的标题',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Text('用户的内容'),
                    Text('用户的时间'),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: onTapText,
        ));
  }

  void onTapText() {}
}
