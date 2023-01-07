import 'dart:html' as html;

import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_progress_spinner.dart';
import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/models/project_model.dart';
import 'package:fair_online/views/top_panel/qr/qr_code_dialog.dart';
import 'package:fair_online/views/top_panel/top_panel_view.dart';
import 'package:fair_online/views/top_panel/upload/upload_plugin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

/**
 * 顶部控制面板
 */
class TopPanel extends StatefulWidget {
  final bool showTab;

  TopPanel({Key? key, this.showTab = true}) : super(key: key);

  @override
  TopPanelState createState() => TopPanelState();
}

class TopPanelState extends State<TopPanel>
    with SingleTickerProviderStateMixin {
  late TabController controller; //底部导航控制器

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    //TabBar监听器
    controller.addListener(() => _onTabChanged());
  }

  @override
  Widget build(BuildContext context) {
    return TopPanelView(this);
  }

  _onTabChanged() {
    if (controller.indexIsChanging) {
      if (this.mounted) {
        context.read<AppModel>().currentFlutterEditorPage =
            controller.index == 0
                ? FlutterEditorPage.Flutter
                : FlutterEditorPage.FairDsl;
      }
    }
  }

  /// 手机扫码预览
  void onQrCode() async {
    Dialogs.show(QrCodeDialog(_onSubmit));
  }

  ///上传补丁
  void onPluginUpload() async {
    Dialogs.show(UploadPluginDialog(_onSubmit));
  }

  Future<void> _onSubmit(appId, bundleName, patchUrl) async {
    var projectModel = context.read<ProjectModel>();
    var result = await projectModel.uploadPlugin(appId, bundleName, patchUrl);
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '上传补丁失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    } else {
      Dialogs.show(
        OkCancelDialog(
          message: '上传成功',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
    }
  }

  void onProjectDownload() async {
    Dialogs.show(
      OkCancelDialog(
        message: '确定要导出当前工程？',
        onCancelPressed: () => Navigator.pop(context),
        onOkPressed: () {
          Navigator.pop(context);
          _exportProject(context);
        },
      ),
    );
  }

  Future<void> _exportProject(BuildContext context) async {
    Dialogs.show(StyledProgressSpinner());
    var projectModel = context.read<ProjectModel>();
    var result = await projectModel.exportProject();
    Navigator.pop(context);
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '工程导出失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    _downloadProject(result.result);
  }
}

void _downloadProject(String url) {
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = path.basename(url);
  html.document.body?.children.add(anchor);
  // download
  anchor.click();
  // cleanup
  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

void onProgress(int total, int progress) {
  print(total);
  print(progress);
}
