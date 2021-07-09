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

  // 监听listview的滑动
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _refresh();
    // 监听滑动
    _scrollController = ScrollController()
      ..addListener(() {
        //判断是否滑到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.addAll(
            List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
      });
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        list = List.generate(Random().nextInt(20) + 15, (i) => 'Item $i');
      });
    });
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
