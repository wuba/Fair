import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/views/main/main_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'left_panel_view.dart';

/**
 * 左边控制面板
 */
class LeftPanel extends StatefulWidget {
  @override
  LeftPanelState createState() => LeftPanelState();
}

class LeftPanelState extends State<LeftPanel> {
  @override
  Widget build(BuildContext context) {
    return LeftPanelView(this);
  }

  void setCurrentPage(MainPage pageType){
    context.read<AppModel>().currentMainPage = pageType;
  }

  void setCurrentFlutterEditorLeftPanel(FlutterEditorLeftPanel flutterEditorLeftPanel){
    context.read<AppModel>().currentFlutterEditorLeftPanel = flutterEditorLeftPanel;
  }

  void setCurrentFlutterEditorPage(FlutterEditorPage flutterEditorPage){
    context.read<AppModel>().currentFlutterEditorPage = flutterEditorPage;
  }

}
