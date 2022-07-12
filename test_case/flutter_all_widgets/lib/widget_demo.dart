
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_all_widgets/outlinebutton/outlinebutton_demo.dart';
import 'package:flutter_all_widgets/rich_text/rich_text_demo.dart';

import 'checkbox/checkbox_demo.dart';
import 'circularProgressIndicator/circular_progressIndicator_demo.dart';
import 'cupertino_tabbar/cupertino_tabbar_demo.dart';
import 'cupertinoalertdialog/alert_dialog_demo.dart';
import 'widget_item.dart';

class WidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "All Widget Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  Widget addWidget(BuildContext context, String title, Widget widget) {
    return  Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: GestureDetector(
          child: Text(title),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => widget));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<WidgetItem> widgets = [
      WidgetItem("OutlineButton", OutlineButtonDemo()),
      WidgetItem("Checkbox", CheckboxDemo()),
      WidgetItem("CupertinoTabBar", CupertinoTabBarDemo()),
      WidgetItem("CupertinoAlertDialog", AlertDialogDemo()),
      WidgetItem("CircularProgressIndicator", CircularProgressIndicatorDemo()),
      WidgetItem("RichText", RichTextDemo()),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("All Widget Demo"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Sugar.map(widgets,
                  builder: (item) =>
                      addWidget(context, item.title, item.className)).toList(),
            ),
          ],
        ));
  }
}
