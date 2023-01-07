import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:fair_online/editor/editing/codemirror_options.dart';
import 'package:fair_online/editor/editing/editor_codemirror.dart';
import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/views/use_code/dialog/use_custom_action_dialog_view.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class UseCustomActionDialog extends StatefulWidget {
  CustomActionInfo customActionInfo;

  UseCustomActionDialog(this.customActionInfo);

  @override
  State<StatefulWidget> createState() {
    return UseCustomActionDialogState(customActionInfo);
  }
}

class UseCustomActionDialogState extends State<UseCustomActionDialog> {
  static const String copyEditorViewType = 'custom-action-copy-editor';
  CustomActionInfo customActionInfo;
  late Editor dartEditor;
  late Editor fairEditor;

  UseCustomActionDialogState(this.customActionInfo);

  @override
  void initState() {
    super.initState();
    final html.HtmlElement element = html.DivElement();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(copyEditorViewType,
        (int viewId) {
      return element;
    });
    // Set up CodeMirror
    dartEditor =
        codeMirrorFactory.createFromElement(element, options: codeMirrorOptions)
          ..theme = 'darkpad'
          ..mode = 'dart'
          ..readOnly = true
          ..showLineNumbers = true;
    _requestActionCode();
  }

  void _requestActionCode() async {
    final params = GetPageRequest();
    params.pagePath = widget.customActionInfo.path;
    final request = dartServices.getPage(params).timeout(serviceCallTimeout);
    try {
      final response = await request;
      final code = response.result;
      if (code.isNotEmpty) {
        dartEditor.document.value = code;
        dartEditor.resize();
      }
    } catch (e) {
      print(e);
    }
  }

  String getActionCode() => dartEditor.document.value;

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(child: UseCustomActionDialogView(this));
  }
}
