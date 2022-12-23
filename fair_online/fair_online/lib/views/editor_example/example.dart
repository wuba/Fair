import 'package:fair_online/app/themes.dart';
import 'package:fair_online/editor/component/analyze_widget.dart';
import 'package:fair_online/editor/component/editor_panel_widget.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/component/flutter_editor_widget.dart';
import 'package:fair_online/editor/component/preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

class Example extends StatefulWidget {
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late FlutterEditorController controller;

  @override
  void initState() {
    super.initState();
    controller = FlutterEditorController(key: "example");
    controller.runMode = RunMode.singlePage;
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Stack(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: FlutterEditor(controller: controller,),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Analyze(controller: controller,),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: EditorPanel(controller: controller,),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Preview(controller: controller,),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ///run按钮
          ValueListenableBuilder<bool>(
              valueListenable: controller.isRunningNotifier,
              builder: (context, value, child) {
                return PointerInterceptor(
                  intercepting: true,
                  child: ElevatedButton.icon(
                      icon: value
                          ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              theme.accent1Darker),
                          backgroundColor: theme.grey,
                          strokeWidth: 3.0,
                        ),
                      )
                          : Icon(
                        Icons.play_arrow,
                        size: 20,
                      ),
                      label: Text('Run'),
                      style: ButtonStyle(
                        minimumSize:
                        MaterialStateProperty.all(Size(100, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            value ? theme.bg2 : theme.accent1),
                      ),
                      onPressed: () {
                        controller.handleRun();
                      }),
                );
              }),
        )
      ],
    );
  }
}
