import 'package:fair_online/app/themes.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/component/preview_widget.dart';
import 'package:flutter/material.dart';

/**
 * Flutter预览页面
 */
class FlutterPreview extends StatelessWidget {
  FlutterEditorController controller;

  FlutterPreview(this.controller);

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme.of(context);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ValueListenableBuilder<bool>(
                      valueListenable: controller.isRunningNotifier,
                      builder: (context, value, child) {
                        return ElevatedButton.icon(
                          icon: value
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        appTheme.accent1Darker),
                                    backgroundColor: appTheme.grey,
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
                                value ? appTheme.bg2 : appTheme.accent1),
                          ),
                          onPressed: () =>
                              controller.handleRun(buildContext: context),
                        );
                      }),
                ),
              ),
            ],
          ),
          Container(height: 2, color: appTheme.divider),
          Flexible(
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Preview(controller: controller),
              );
            }),
          ),
        ],
      ),
    );
  }
}
