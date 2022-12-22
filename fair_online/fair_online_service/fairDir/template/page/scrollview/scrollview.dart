import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class @@PageName@@ extends StatefulWidget {
  const @@PageName@@({Key? key}) : super(key: key);

  @override
  State<@@PageName@@> createState() => _@@PageName@@State();
}

class _@@PageName@@State extends State<@@PageName@@> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('CustomScrollView模版'),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Flutter Best UI x Fair 最佳实践',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
          ),

          ///网格
          SliverGrid(
            gridDelegate: Sugar.sliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0,
            ),
            delegate: SliverChildBuilderDelegate(_itemBuilder, childCount: 3),
          ),

          ///列表
          SliverList(
            delegate: SliverChildBuilderDelegate(_itemBuilder, childCount: 3),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(context, index) {
    return Container(
      color: Colors.yellow,
      child: Text('$index'),
      width: 100,
      height: 100,
    );
  }
}
