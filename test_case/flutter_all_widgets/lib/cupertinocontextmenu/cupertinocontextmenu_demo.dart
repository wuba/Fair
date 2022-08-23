import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * CupertinoContextMenu的效果类似于IOS的3D Touch，长按弹出菜单
 */
class CupertinoContextMenuDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterCupertinoContextMenuPage(),
          FairWidget(
            path: 'assets/bundle/cupertinocontextmenu/lib_cupertinocontextmenu_cupertinocontextmenu_widget.fair.json',
          )
        ],
      ),
    );
  }
}

class FlutterCupertinoContextMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CupertinoContextMenu(
          actions: [
            CupertinoContextMenuAction(
              child: Text('菜单1'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoContextMenuAction(
              child: Text('菜单2'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
