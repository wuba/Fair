

import 'package:flutter/material.dart';
import 'package:flutter_all_widgets/animatedalign/animatedalign_demo.dart';
import 'package:flutter_all_widgets/outlinebutton/outlinebutton_demo.dart';
import 'package:flutter_all_widgets/rich_text/rich_text_demo.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
import 'animated/positioned/animatedpositioned_demo.dart';
import 'animated/size/animatedsize_demo.dart';
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget addWidget(BuildContext context, String title, Widget widget) {
    return Container(
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
      WidgetItem("AnimatedPositioned", AnimatedPositionedDemo()),
      WidgetItem("AnimatedSize", AnimatedSizeDemo()),
    ];

    Widget _widgetCard(WidgetItem item, int index) {
      return Container(
        height: ((index % 5 + 1) * 50).toDouble(),
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: GestureDetector(
            child: Text(
              "$index:${item.title}",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => item.className));
            }),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("All Widget Demo"),
        ),
        body: MasonryGridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          shrinkWrap: true,
//          physics:const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index < widgets.length) {
              return _widgetCard(widgets[index], index);
            }
            return null;
          },
        ));
  }
}