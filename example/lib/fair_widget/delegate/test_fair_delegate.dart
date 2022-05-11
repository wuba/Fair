import 'package:example/main.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

///Delegate需要集成FairDelegate
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
    return Container(
      height: 60,
      color: randomColor(),
    );
  }
}
