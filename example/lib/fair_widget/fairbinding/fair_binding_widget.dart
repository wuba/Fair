import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/// 本地自定义的 Widget。
class FairBindingWidget extends StatefulWidget {
  const FairBindingWidget({Key? key}) : super(key: key);

  @override
  _FairBindingWidgetState createState() => _FairBindingWidgetState();
}

class _FairBindingWidgetState extends State<FairBindingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text('我是一个本地自定义 Widget'),
      ),
    );
  }
}
