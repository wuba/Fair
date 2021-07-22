import 'dart:math';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'fair_example_main.js.dart';

@FairPatch()
class JRListWidget extends StatefulWidget {
  @override
  JRListState createState() => JRListState();
}

class JRListState extends State<JRListWidget> {

  @override
  void initState() {
    super.initState();
    onLaunch();
  }

  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull Refresh'),
      ),
      body: Center(
        child: RefreshIndicator( //下拉刷新
            displacement: 10.0,
            child: Sugar.ifEqualBool(listIsEmpty(), trueValue: Center(
              child: CircularProgressIndicator(), //没有数据就转圈
            ), falseValue: ListView.builder(
                controller: _scrollController,
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  if (index == list.length) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListTile(
                    title: Text(list[index]),
                  );
                })),
            onRefresh: _refresh
        ),
      ),
    );
  }
}
