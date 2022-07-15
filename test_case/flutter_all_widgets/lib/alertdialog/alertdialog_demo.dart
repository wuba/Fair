

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class AlertDialogDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog'),
      ),
      body: Column(
        children: [
          FlutterAlerDialogPage(),
          FairWidget(
            path: 'assets/bundle/alertdialog/lib_alertdialog_alertdialog_widget.fair.json',
            data: {
              'fairProps':jsonEncode({'content':'Fair description'})
            },
          )
        ],
      ),
    );
  }
  
}

class FlutterAlerDialogPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ()=>showDialog<String>(
      context: context,
      builder: (BuildContext context)=>AlertDialog(
        title: Text('Flutter AlertDialog Title'),
        content: Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(onPressed: ()=>Navigator.pop(context,'取消'), child: Text('Cancel')),
          TextButton(onPressed: ()=>Navigator.pop(context,'确定'), child: Text('Ok'))
        ],
      )
    ), child: Text('Flutter Show Dialog'));
  }
  
}