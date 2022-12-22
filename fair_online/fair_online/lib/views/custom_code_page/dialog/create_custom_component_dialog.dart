import 'dart:typed_data';

import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/custom_code_page/code_template.dart';
import 'package:fair_online/views/custom_code_page/dialog/code_compile_dialog.dart';
import 'package:fair_online/views/custom_code_page/dialog/create_custom_component_dialog_view.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../base/components/styled_dialogs.dart';

class CreateCustomComponentDialog extends StatefulWidget {
  final CustomCodeEditType editType;
  final SourceType sourceType;
  CustomComponentInfo? info;

  CreateCustomComponentDialog(this.editType, this.sourceType, {this.info});

  @override
  State<StatefulWidget> createState() {
    return CreateCustomComponentDialogState();
  }
}

class CreateCustomComponentDialogState
    extends State<CreateCustomComponentDialog> {
  FlutterEditorController controller =
      FlutterEditorController(key: "custom_code_component");

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

  @override
  Widget build(BuildContext context) {
    return CreateCustomComponentDialogView(this);
  }

  void setInitCodeByType() {
    if (widget.sourceType == SourceType.temp) {
      controller.code = CodeTemplateInitUtils.getTemplateCode();
    } else {
      controller.loadPage(widget.info!.path);
    }
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
    Uint8List? previewScreenshot;
    previewScreenshot = controller.previewScreenshot.value;
    final response = await context
        .read<CustomCodeModel>()
        .createCustomComponent(
            widget.editType, name, desc, content, previewScreenshot);
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

  void showCompileDialog() {
    Dialogs.show(CodeCompileDialog(controller: controller));
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
