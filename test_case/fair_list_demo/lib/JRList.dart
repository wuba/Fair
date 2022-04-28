import 'dart:math';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JRListWidget extends StatefulWidget {
  @override
  JRListState createState() => JRListState();
}

@FairPatch()
class JRListState extends State<JRListWidget>
{
  @FairWell("list")
  List list = List();
  // 监听listview的滑动
  @FairWell("_scrollController")
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

  @FairWell("_loadMore")
  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.addAll(
            List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
      });
    });
  }

  @FairWell("_refresh")//TODO:方法带参数怎么办？
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
        child: RefreshIndicator(//下拉刷新
            displacement: 10.0,
            child: ListView.builder(
                controller: _scrollController,
                itemCount: list.length,
                itemBuilder: itemBuilder),
            onRefresh: _refresh
        ),
      ),
    );
  }

  @FairWell("itemBuilder")
  Widget itemBuilder(context, index) {
    // if(index == list.length){
    //                   //   return Padding(
    //                   //     padding: const EdgeInsets.all(10.0),
    //                   //     child: Center(
    //                   //       child: CircularProgressIndicator(),
    //                   //     ),
    //                   //   );
    //                   // }
    return ListTile(
      title: Text(list[index]),
    );
  }
}
