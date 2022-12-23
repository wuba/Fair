import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fair/fair.dart';

typedef DataSource = Function(int index);

class ListviewCommonDelegate extends FairDelegate {
  final String path;
  final DataSource dataSource;

  ListviewCommonDelegate({required this.path, required this.dataSource});

  @override
  Map<String, Function> bindFunction() {
    ///此处添加fair widget中声明的_itemBuilder
    ///key必须与声明的方法名一致
    var fun = super.bindFunction();
    fun.addAll({
      '_itemBuilder': _itemBuilder,
    });
    return fun;
  }

  Widget _itemBuilder(context, index) {
    return FairWidget(
      name: path,
      path: path,
      data: {
        'fairProps': jsonEncode(dataSource.call(index)),
      },
    );
  }
}
