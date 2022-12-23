import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/editing/editor.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

///代码编辑器
class FlutterEditor extends StatefulWidget {

  FlutterEditorController controller;

  FlutterEditor({required this.controller});

  @override
  State<FlutterEditor> createState() => FlutterEditorState();
}

class FlutterEditorState extends State<FlutterEditor> {

  late FlutterEditorController controller;

  Editor? editor;

  @override
  void initState() {
    super.initState();
    controller = widget.controller
    ..initialized()
    .then((editor) {
      this.setState(() {
        this.editor = editor;
        Future.delayed(const Duration(milliseconds: 100))
            .then((value) => editor.resize());
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.requestFocus();
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => editor?.resize());
  }

  @override
  Widget build(BuildContext context) {
    if (editor == null) {
      return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ));
    } else {
      return LayoutBuilder(builder: (context, dimens) {
        editor?.setSize(dimens.maxWidth, dimens.maxHeight);
        return Stack(
          children: [
            HtmlElementView(
              viewType: controller.getCodeMirrorViewType(),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: controller.isEditorShowLoadingNotifier,
                builder: (context, value, child) {
                  return value
                      ? PointerInterceptor(
                    intercepting: true,
                    child: Container(
                      color: Color(0xFF0E161F),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  )
                      : Container();
                })
          ],
        );
      });
    }
  }
}