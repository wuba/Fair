import 'dart:convert';

import 'package:example/main.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

///Delegate需要继承FairDelegate
///并且在fairApp中注册这个Delegate
class TestFairDelegate extends FairDelegate {
  @override
  Map<String, Function> bindFunction() {
    var bindFunction = super.bindFunction();
    bindFunction.addAll({
      ///此处添加fair widget中声明的_itemBuilder
      ///key必须与声明的方法名一致
      '_itemBuilder': _itemBuilder
    });
    return bindFunction;
  }

  ///此处是正在执行的_itemBuilder方法
  Widget _itemBuilder(context, index) {
    ///如果再delegate中想获取fairwidget中的变量或者调用某个方法
    ///funcName 是fairwidget中的方法名
    ///parameters 方法参数数组
    var invokeMethodSync = runtime?.invokeMethodSync(pageName, 'getData', null);
    var json = jsonDecode(invokeMethodSync!);
    var json2 = json['result']['result'];

    return Container(
      height: 60,
      child: Center(child: Text(json2[index]),),
      color: randomColor(),
    );
  }
}
