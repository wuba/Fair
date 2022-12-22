import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/custom_code_page/custom_code_page_view.dart';
import 'package:fair_online/views/custom_code_page/dialog/create_custom_action_dialog.dart';
import 'package:fair_online/views/custom_code_page/dialog/create_custom_component_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * 自定义事件页面
 */
class CustomCodePage extends StatefulWidget {
  @override
  CustomCodePageState createState() => CustomCodePageState();
}

class CustomCodePageState extends State<CustomCodePage>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return CustomCodePageView(this);
  }

  showCreateDialog() {
    switch (getTypeByIndex()) {
      case TYPE_COMPONENT:
        Dialogs.show(CreateCustomComponentDialog(CustomCodeEditType.create, SourceType.temp));
        break;
      case TYPE_ACTION:
        Dialogs.show(CreateCustomActionDialog(CustomCodeEditType.create, SourceType.temp));
        break;
    }
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

  int getTabIndex() {
    return index;
  }

  String getTypeByIndex() {
    if (index == 0) {
      return TYPE_COMPONENT;
    } else if (index == 1) {
      return TYPE_ACTION;
    }
    return TYPE_COMPONENT;
  }
}
