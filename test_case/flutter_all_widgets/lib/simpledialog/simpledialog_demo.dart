import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SimpleDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleDialogDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SimpleDialog(
              title: Text('提示'),
              children: <Widget>[
                Container(
                  height: 80,
                  alignment: Alignment.center,

                  child: Text('确认删除吗？'),
                ),
                Divider(height: 1,),
                FlatButton(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop('cancel');
                  },
                ),
                Divider(height: 1,),
                FlatButton(
                  child: Text('确认'),
                  onPressed: () {
                    Navigator.of(context).pop('ok');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/simpledialog/lib_simpledialog_simpledialog_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
