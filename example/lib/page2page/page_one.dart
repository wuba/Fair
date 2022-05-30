import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/// 本demo演示两个动态页面之间的跳转和传值
///
/// 从 [PageOne] 跳转到 [PageTwo] 并传递一个 String 类型的 id 参数
@FairPatch()
class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PageOne'),
        ),
        body: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('点击右下角按钮跳转到下个页面'),
            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'fair_page_two', arguments: {
              'path': 'assets/bundle/lib_page2page_page_two.fair.json',
              'data': {'title': 'PageTwo'}
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.arrow_forward_sharp),
        )
    );
  }
}
