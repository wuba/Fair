import 'dart:math';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class JRListWidget extends StatefulWidget {
  var fairProps;

  JRListWidget(dynamic data) {
    fairProps = data;
  }

  @override
  JRListState createState() => JRListState();
}

class JRListState extends State<JRListWidget> {

  @FairProps()
  var fairProps;

  List list = List();

// 监听listview的滑动
  ScrollController _scrollController;

  bool listIsEmpty() {
    return list == null || list.isEmpty;
  }

  Future _onLoadMore() async {
    await Future.delayed(Duration(seconds: 100), () {
      list.addAll(
          List.generate(Random().nextInt(5) + 5, (i) => 'more Item $i'));
      setState(() {});
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      list.insertAll(
          0, List.generate(Random().nextInt(5) + 5, (i) => 'refresh Item $i'));
      setState(() {

      });
    });
  }

  void onLaunch() {
    Future.delayed(Duration(seconds: 1), () {
      list.insertAll(
          0, List.generate(Random().nextInt(5) + 15, (i) => 'Item $i'));
      setState(() {
      });
    });

    // 监听滑动
    _scrollController = ScrollController()
      ..addListener(() {
        //判断是否滑到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _onLoadMore();
        }
      });
  }

  void onDispose() {
    _scrollController.dispose();
  }

  Widget _itemBuilder(BuildContext context, int index) {
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
  }

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
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
        title: Text('ListLoadMore'),
      ),
      body: Center(
        child: RefreshIndicator(
            //下拉刷新
            displacement: 10.0,
            child: Sugar.ifEqualBool(listIsEmpty(),
                trueValue: Center(
                  child: CircularProgressIndicator(), //没有数据就转圈
                ),
                falseValue: ListView.builder(
                    controller: _scrollController,
                    itemCount: list.length + 1,
                    itemBuilder: _itemBuilder)),
            onRefresh: _onRefresh),
      ),
    );
  }
}
