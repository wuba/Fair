
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/views/dependency/dialog/create_dependency_dialog_view.dart';
import 'package:flutter/cupertino.dart';

typedef onAddDependencyCallback = void Function(String name, String version);

class CreateDependencyDialog extends StatefulWidget {

  onAddDependencyCallback onAddDependency;

  CreateDependencyDialog(this.onAddDependency);

  @override
  State<StatefulWidget> createState() {
    return CreateDependencyDialogState();
  }

}

class CreateDependencyDialogState extends State<CreateDependencyDialog> {
  @override
  Widget build(BuildContext context) {
    return CreateDependencyDialogView(this);
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void ok(String inputName, String inputVersion) {

    if(inputName.isEmpty) {
      Dialogs.show(ToastDialog(title: "", message: "请输入依赖名称"));
      return;
    }
    if(inputVersion.isEmpty) {
      Dialogs.show(ToastDialog(title: "", message: "请输入依赖版本"));
      return;
    }
    widget.onAddDependency.call(inputName, inputVersion);
    Navigator.of(context).pop();
  }

}