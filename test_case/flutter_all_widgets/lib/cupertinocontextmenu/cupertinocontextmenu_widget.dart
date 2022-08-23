import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairCupertinoContextMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FairCupertinoContextMenuPage();
}

class _FairCupertinoContextMenuPage extends State<FairCupertinoContextMenuPage> {

  void _onPressed(){
    Navigator.pop(context);
  }

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
              onPressed: _onPressed,
            ),
            CupertinoContextMenuAction(
              child: Text('菜单2'),
              onPressed:_onPressed,
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
