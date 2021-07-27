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
      '_onRefresh': _onRefresh,
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
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onLoadMore() {
    runtime?.invokeMethod(pageName, '_onLoadMore', null);
  }

  Future<void> _onRefresh() async {
    await runtime?.invokeMethod(pageName, '_onRefresh', null);
  }

  Widget _itemBuilder(context, index) {
    var result = runtime?.invokeMethodSync(pageName, '_onItemByIndex', [index]);
    var value = jsonDecode(result);
    var itemData = value['result']['result'];
    return FairWidget(
      name: itemData,
      path: 'assets/bundle/lib_src_page_list_sample_list_with_logic.fair.json',
      data: {'fairProps': jsonEncode({'item': '${itemData}'})},
    );
  }
}
