import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class PageTwo extends StatefulWidget {
  PageTwo({Key? key,this.fairProps}) : super(key: key);

  dynamic fairProps;

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String getTitle() {
    return fairProps['title'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /// 如果需要进行字符串拼接的话，在build()方法里进行拼接即可，不建议在getTitle()
          /// 方法里做字符串拼接
          title: Text('参数：${getTitle()}'),
        ),
        body: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('xxxxx'),
            )
        ),
    );
  }
}
