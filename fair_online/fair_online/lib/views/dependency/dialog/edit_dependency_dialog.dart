
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/views/dependency/dialog/edit_dependency_dialog_view.dart';
import 'package:flutter/cupertino.dart';

typedef OnEditDependencyCallback = void Function(String name, String version);

class EditDependencyDialog extends StatefulWidget {
  String name;
  String version;
  OnEditDependencyCallback editCallback;
  EditDependencyDialog(this.name, this.version, this.editCallback);

  @override
  State<StatefulWidget> createState() {
    return EditDependencyDialogState();
  }
}

class EditDependencyDialogState extends State<EditDependencyDialog> {
  @override
  Widget build(BuildContext context) {
    return EditDependencyDialogView(this);
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void edit(String inputName, String inputVersion) {

    if(inputVersion.isEmpty) {
      Dialogs.show(ToastDialog(title: "", message: "请输入依赖版本"));
      return;
    }
    widget.editCallback.call(inputName, inputVersion);
    Navigator.of(context).pop();
  }

}