import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/use_code/dialog/use_custom_action_dialog.dart';
import 'package:fair_online/views/use_code/dialog/use_custom_widget_dialog.dart';
import 'package:fair_online/views/use_code/use_code_list_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 页面列表
class UseCodeListPage extends StatefulWidget {
  FlutterEditorController controller;
  UseCodeListPage(this.controller);

  @override
  State<StatefulWidget> createState() {
    return UseCodeListPageState();
  }

}

class UseCodeListPageState extends State<UseCodeListPage> with SingleTickerProviderStateMixin {

  late TabController controller;
  int index = 0;

  @override
  void initState() {
    CustomCodeModel model = context.read<CustomCodeModel>();
    model.initialized();
    super.initState();
    controller = TabController(length: 2, vsync: this);
    //TabBar监听器
    controller.addListener(() => _onTabChanged());
  }

  _onTabChanged() {
    if (controller.indexIsChanging) {
      if (this.mounted) {
        setState(() {
          index = controller.index;
        });
      }
    }
  }

  void showUseCustomWidgetDialog(CustomComponentInfo customCodeInfo){
    Dialogs.show(UseCustomWidgetDialog(customCodeInfo));
  }

  void showUseCustomActionDialog(CustomActionInfo customActionInfo){
    Dialogs.show(UseCustomActionDialog(customActionInfo));
  }

  @override
  Widget build(BuildContext context) {
    return UseCodeListPageView(this);
  }


}