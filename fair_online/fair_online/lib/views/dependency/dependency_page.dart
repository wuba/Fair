import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/dialog/dialog_manager.dart';
import 'package:fair_online/base/dialog/loading_dialog.dart';
import 'package:fair_online/models/dependency_file_model.dart';
import 'package:fair_online/views/dependency/config_file_utils.dart';
import 'package:fair_online/views/dependency/dependency_info.dart';
import 'package:fair_online/views/dependency/dependency_page_view.dart';
import 'package:fair_online/views/dependency/dialog/create_dependency_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DependencyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DependencyPageState();
  }
}

class DependencyPageState extends State<DependencyPage> {
  List<DependencyInfo> list = [];

  @override
  void initState() {
    DependencyFileModel model = context.read<DependencyFileModel>();
    model.initialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DependencyFileModel model = context.watch<DependencyFileModel>();
    String content = model.componentsResponse.filePath;
    getDependencyList(content);
    return DependencyPageView(this);
  }

  void getDependencyList(String content) {
    list.clear();
    Map? dependency = ConfigFileUtils.getDependencies(content);
    if (dependency != null) {
      dependency.forEach((key, value) {
        if (key != "flutter" && key != "fair") {
          DependencyInfo info = DependencyInfo(key, value.toString());
          list.add(info);
        }
      });
    }
  }

  ///显示添加依赖的弹框
  void showAddDependencyDialog() {
    Dialogs.show(CreateDependencyDialog(onAddDependency));
  }

  void deleteDependency(String name, String version) {
    deleteDependencyToYaml(name, version);

    int length = list.length;
    if (length > 0) {
      for (int index = 0; index < length; index++) {
        DependencyInfo info = list[index];
        if (info.name == name) {
          list.remove(info);
          doRefresh();
          return;
        }
      }
    }
  }

  ///添加依赖输入完成
  void onAddDependency(String name, String version) {
    addDependencyToYaml(name, version);
    DependencyInfo info = new DependencyInfo(name, version);
    list.add(info);
    doRefresh();
  }

  void editDependency(String name, String version) {
    updateDependencyToYaml(name, version);
    int length = list.length;
    if (length > 0) {
      for (int index = 0; index < length; index++) {
        DependencyInfo info = list[index];
        if (info.name == name) {
          info.setVersion = version;
          doRefresh();
          return;
        }
      }
    }
  }

  void doRefresh() {
    if (mounted) {
      setState(() {});
    }
  }

  ///重新配置依赖
  void doPubGet() async {
    DialogManager().showCustomDialog(
        context, "dependency_do_pub", LoadingDialog("pub get..."));
    var result = await context.read<DependencyFileModel>().doPubGet();
    DialogManager().dismissDialog(context, "dependency_do_pub");
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '执行pub get失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
    }
  }

  //往yaml文件中添加依赖
  void addDependencyToYaml(String name, String version) {
    context
        .read<DependencyFileModel>()
        .changeDependency(DependencyFileModel.TYPE_ADD, name, version);
  }

  //往yaml文件中添加依赖
  void updateDependencyToYaml(String name, String version) {
    context
        .read<DependencyFileModel>()
        .changeDependency(DependencyFileModel.TYPE_EDIT, name, version);
  }

  void deleteDependencyToYaml(String name, String version) {
    context
        .read<DependencyFileModel>()
        .changeDependency(DependencyFileModel.TYPE_DELETE, name, version);
  }
}
