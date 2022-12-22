import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:fair_online/editor/editing/codemirror_options.dart';
import 'package:fair_online/editor/editing/editor_codemirror.dart';
import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/views/use_code/dialog/use_custom_widget_dialog_view.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class UseCustomWidgetDialog extends StatefulWidget {
  CustomComponentInfo customComponentInfo;

  UseCustomWidgetDialog(this.customComponentInfo);

  @override
  State<StatefulWidget> createState() {
    return UseCustomWidgetDialogState(customComponentInfo);
  }
}

class UseCustomWidgetDialogState extends State<UseCustomWidgetDialog> {
  static const String copyEditorViewType = 'custom-component-copy-editor';
  static const String fairWidgetEditorViewType = 'fair-widget-editor';
  CustomComponentInfo customCodeInfo;
  late Editor dartEditor;
  late Editor fairEditor;

  UseCustomWidgetDialogState(this.customCodeInfo);

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
    getCode();
    final html.HtmlElement fairWidgetElement = html.DivElement();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(fairWidgetEditorViewType,
        (int viewId) {
      return fairWidgetElement;
    });
    // Set up CodeMirror
    fairEditor = codeMirrorFactory.createFromElement(fairWidgetElement,
        options: codeMirrorOptions)
      ..theme = 'darkpad'
      ..mode = 'dart'
      ..readOnly = true
      ..showLineNumbers = true;
    fairEditor.document.value = customCodeInfo.fairWidgetCode;
  }

  void getCode() async {
    final params = GetPageRequest();
    params.pagePath = widget.customComponentInfo.path;
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

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(child: UseCustomWidgetDialogView(this));
  }
}

String fairWidget = '''
FairWidget(
  name: 'lib_src_page_list_item_hotel_listview_item_template2',
  path: 'assets/bundle/lib_src_page_list_item_hotel_listview_item_template2.fair.json',
);
''';