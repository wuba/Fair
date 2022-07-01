import 'package:example/fair_widget/fairbinding/fair_binding_widget.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairBindingSample extends StatelessWidget {
  const FairBindingSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FairBinding 注解演示'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello World！',
            ),
            // 引用本地自定义的 FairBindingWidget
            FairBindingWidget(),
          ],
        ),
      )
    );
  }
}
