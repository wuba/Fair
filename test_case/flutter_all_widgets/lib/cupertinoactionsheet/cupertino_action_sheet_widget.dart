
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairCupertinoActionSheetPage extends StatefulWidget{
   FairCupertinoActionSheetPage({Key key,this.fairProps}) : super(key: key);

  dynamic fairProps;

  @override
  State<StatefulWidget> createState()=> _FairCupertinoActionSheetPageState();

}

class _FairCupertinoActionSheetPageState extends State<FairCupertinoActionSheetPage>{

  @FairProps()
  var fairProps;


  @override
  void initState() {
    fairProps = widget.fairProps;
  }

  void _showActionSheet(){
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context)=>CupertinoActionSheet(
          title: Text('请选择'),
          message:  Text('Message'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              /// This parameter indicates the action would be a default
              /// defualt behavior, turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('默认Action'),
            ),
            CupertinoActionSheetAction(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Action1'),
            ),
            CupertinoActionSheetAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as delete or exit and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Action2'),
            ),
          ],
        )
    );
  }

  String _getTitle(){
    return fairProps['title'];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:CupertinoNavigationBar(
        middle: Text(_getTitle()),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: _showActionSheet,
          child: Text('Fair CupertinoActionSheet'),
        ),
      ),
    );
  }

}