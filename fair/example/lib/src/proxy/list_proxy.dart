import 'dart:convert';
import 'dart:math';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListDelegate extends FairDelegate {
  ScrollController _scrollController;

  @override
  Map<String, Function> bindFunction() {
    var functions = super.bindFunction();
    functions.addAll({
      '_itemBuilder': _itemBuilder,
    });
    return functions;
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var pros = super.bindValue();

    pros.addAll({
      '_scrollController': () => _scrollController,
    });
    return pros;
  }

  @override
  void initState() {
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

  @override
  void didChangeDependencies() {
    runtime?.invokeMethod(pageName, 'onLaunch', null);
  }

  @override
  void dispose() {
    super.dispose();
    runtime?.invokeMethod(pageName, 'onDispose', null);
    _scrollController.dispose();
  }

  void _onLoadMore() {
    runtime?.invokeMethod(pageName, 'onLoadMore', null);
  }

  Widget _itemBuilder(context, index) {
    var result = runtime?.invokeMethodSync(pageName, 'onListData', null);
    var value = jsonDecode(result);
    var itemData = value['result']['result'][index];
    return FairWidget(
      name: itemData,
      path: 'assets/bundle/lib_src_page_list_sample_list_with_logic.fair.json',
      jsPath:'assets/js/lib_src_page_list_sample_list_with_logic.fair.js',
      data: {'fairProps': jsonEncode({'item': '${itemData}'})},
    );
  }
}
