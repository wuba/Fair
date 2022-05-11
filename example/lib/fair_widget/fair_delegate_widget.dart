import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

///关于fair delegate如何使用
///具体使用场景
@FairPatch()
class FairDelegateWidget extends StatefulWidget {
  const FairDelegateWidget({Key? key}) : super(key: key);

  @override
  State<FairDelegateWidget> createState() => _FairDelegateWidgetState();
}

class _FairDelegateWidgetState extends State<FairDelegateWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fair delegate的使用"),
      ),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 10,
      ),
    );
  }

  ///fair暂时还不直接识别itemBuilder使用逻辑语句
  ///必须声明成方法,fair内部通过js保存方法,
  ///js无法使用识别dart的context所以js不能识别的方法
  ///建议使用fair delegate去处理
  Widget _itemBuilder(context, index) {
    ///使用delegate后此处返回值无效,可随意返回,真实执行的是fair delegate
    ///中的_itemBuilder方法
    return Container();
  }
}
