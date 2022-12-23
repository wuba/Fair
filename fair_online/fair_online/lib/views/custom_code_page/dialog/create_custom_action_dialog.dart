
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/custom_code_page/dialog/create_custom_action_dialog_view.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../base/components/styled_dialogs.dart';

class CreateCustomActionDialog extends StatefulWidget {
  final CustomCodeEditType editType;
  final SourceType sourceType;
  CustomActionInfo? info;

  CreateCustomActionDialog(this.editType, this.sourceType, {this.info});

  @override
  State<StatefulWidget> createState() {
    return CreateCustomActionDialogState();
  }
}

class CreateCustomActionDialogState extends State<CreateCustomActionDialog> {
  FlutterEditorController controller =
      FlutterEditorController(key: "custom_code_action");

  @override
  void initState() {
    super.initState();
    controller.sourceType = widget.sourceType;
    //自定义组件使用单页面预览模式
    controller.runMode = RunMode.singlePage;
    controller.initialized();
    controller.requestFocus();
    setInitCodeByType();
  }

  void setInitCodeByType() {
    if (widget.sourceType == SourceType.temp) {
      //TODO action的默认代码
      // controller.code = CodeTemplateInitUtils.getTemplateCode();
    } else {
      controller.loadPage(widget.info!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateCustomActionDialogView(this);
  }

  Future<bool> createNewComponent(String name, String desc) async {
    if (name.isEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: '请输入文件名称',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return false;
    }

    String content = controller.code;
    if (content.isEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: '请输入文件内容',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return false;
    }
    final response = await context
        .read<CustomCodeModel>()
        .createCustomAction(widget.editType, name, desc, content);
    if (response.status != 0) {
      Dialogs.show(
        OkCancelDialog(
          message: response.error.message,
          onOkPressed: () => Navigator.pop(context),
        ),
      );
    }
    return response.status == 0;
  }

  @override
  void dispose() {
    super.dispose();
    controller.code = "";
  }

  void importFile({Function? onError}) async {
    final typeGroup = XTypeGroup(label: 'dart', extensions: ['dart']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) {
      return;
    }

    try {
      var name = file.name;
    } catch (e) {}
  }
}
