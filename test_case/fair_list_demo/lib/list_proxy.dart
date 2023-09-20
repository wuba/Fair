import 'dart:math';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListDelegate extends FairDelegate {
  var list = <String>[];
  late ScrollController _scrollController;

  @override
  Map<String, Function> bindFunction() {
    var functions = super.bindFunction();
    functions.addAll({
      '_refresh': _refresh,
      '_loadMore': _loadMore,
      'itemBuilder': itemBuilder,

    });
    return functions;
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var pros = super.bindValue();

    // var value = super.bindValue();
    // value['list'] = () => list;
    // value['_scrollController'] = () => _scrollController;
    // return value;
    pros.addAll({
      'list': () => list,
      '_scrollController': () => _scrollController,
      'list.length': () => list.length,
    });
    return pros;
  }


  @override
  void initState() {
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

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        list = List.generate(Random().nextInt(20) + 15, (i) => 'Item $i');
      });
    });
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.addAll(
            List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
      });
    });
  }

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
