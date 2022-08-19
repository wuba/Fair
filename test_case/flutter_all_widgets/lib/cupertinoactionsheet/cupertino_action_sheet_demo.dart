
import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoActionSheetDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CupertinoActionSheet'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterCupertinoActionSheetPage(title: 'Flutter'),
          ),
          Expanded(child: FairWidget(
            path:'assets/bundle/cupertinoactionsheet/lib_cupertinoactionsheet_cupertino_action_sheet_widget.fair.json',
            data: {
              'fairProps': jsonEncode({'title':'Fair'})
            },
          ))
        ],
      )
    );
  }

}

class FlutterCupertinoActionSheetPage extends StatelessWidget{
  const FlutterCupertinoActionSheetPage({Key key, this.title}) : super(key: key);

  final String title;

  void _showActionSheet(BuildContext context){
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar:CupertinoNavigationBar(
          middle: Text(title),
        ),
      child: Center(
        child: CupertinoButton(
          onPressed: ()=>_showActionSheet(context),
          child: Text('Flutter CupertinoActionSheet'),
        ),
      ),
    );
  }


}

