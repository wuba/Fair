

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class CustomWidget extends StatelessWidget {

  final String title;

  const CustomWidget({Key? key,this.title='Test'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),//滑出选项的面板 动画
      actionExtentRatio: 0.25,
      child: Container(
        height: 60,
        decoration: new BoxDecoration(
          color: Colors.green,
        ),
        width: double.infinity,
      ),
      actions: <Widget>[//左侧按钮列表
        IconSlideAction(
          caption: title,
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => {},
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => {},
        ),
      ],
      secondaryActions: <Widget>[//右侧按钮列表
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => {},
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: (){

          },
        ),
      ],
    );
  }

}