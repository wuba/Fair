
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_all_widgets/animatedalign/animatedalign_demo.dart';
import 'package:flutter_all_widgets/outlinebutton/outlinebutton_demo.dart';
import 'package:flutter_all_widgets/rich_text/rich_text_demo.dart';

import 'absorbpointer/absorbpointer_demo.dart';
import 'alertdialog/alertdialog_demo.dart';
import 'animated/builder/animatedbuilder_demo.dart';
import 'animated/animatedcontainer_demo.dart';
import 'animated/defaulttextstyle/animateddefaulttextstyle_demo.dart';
import 'animated/liststate/animatedliststate_demo.dart';
import 'animated/modalbarrier/animatedmodalbarrier_demo.dart';
import 'animated/opacity/animatedopacity_demo.dart';
import 'animated/physicalmodel/animatedphysicalmodel_demo.dart';
import 'animated/crossfade/animatedcrossfade_demo.dart';
import 'checkbox/checkbox_demo.dart';
import 'circularProgressIndicator/circular_progressIndicator_demo.dart';
import 'cupertino_tabbar/cupertino_tabbar_demo.dart';
import 'cupertinoalertdialog/cupertino_alert_dialog_demo.dart';
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
      WidgetItem("CupertinoAlertDialog", CupertinoAlertDialogDemo()),
      WidgetItem("CircularProgressIndicator", CircularProgressIndicatorDemo()),
      WidgetItem("RichText", RichTextDemo()),
      WidgetItem("AbsorbPointer", AbsorbPointerDemo()),
      WidgetItem("AlertDialog", AlertDialogDemo()),
      WidgetItem("AnimatedAlign", AnimatedAlignDemo()),
      WidgetItem("AnimatedBuilder", AnimatedBuilderDemo()),
      WidgetItem("AnimatedContainer", AnimatedContainerDemo()),
      WidgetItem("AnimatedDefaultTextStyle", AnimatedDefaultTextStyleDemo()),
      WidgetItem("AnimatedCrossFade", AnimatedCrossFadeDemo()),
      WidgetItem("AnimatedListState", AnimatedListStateDemo()),
      WidgetItem("AnimatedModalBarrier", AnimatedModalBarrierDemo()),
      WidgetItem("AnimatedOpacity", AnimatedOpacityDemo()),
      WidgetItem("AnimatedPhysicalModel", AnimatedPhysicalModelDemo()),
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
            Column(),
          ],
        ));
  }
}
