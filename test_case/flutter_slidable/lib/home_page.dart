/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

@FairPatch()
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slidable(
              actionPane: SlidableScrollActionPane(),
              //滑出选项的面板 动画
              actionExtentRatio: 0.25,
              child: Container(
                height: 60,
                decoration: new BoxDecoration(
                  color: Colors.green,
                ),
                width: double.infinity,
              ),
              actions: <Widget>[
                //左侧按钮列表
                IconSlideAction(
                  caption: "title",
                  color: Colors.blue,
                  icon: Icons.archive,
                  onTap: onTagClick,
                ),
                IconSlideAction(
                  caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: onTagClick,
                ),
              ],
              secondaryActions: <Widget>[
                //右侧按钮列表
                IconSlideAction(
                  caption: 'More',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: onTagClick,
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  closeOnTap: false,
                  onTap: onTagClick,
                ),
              ],
            )
            //AnimateWidget(),
          ],
        ),
      ),
    );
  }

  @FairWell('onTagClick')
  void onTagClick(){
    print('11111');
  }
}
