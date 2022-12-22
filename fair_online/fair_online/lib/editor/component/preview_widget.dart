import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:flutter/material.dart';

///预览视图
class Preview extends StatelessWidget {
  FlutterEditorController controller;

  Preview({required this.controller});

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      viewType: controller.getPreviewViewType(),
    );
  }
}
