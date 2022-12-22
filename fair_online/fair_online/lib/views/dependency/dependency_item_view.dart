import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/views/dependency/dependency_info.dart';
import 'package:fair_online/views/dependency/dialog/edit_dependency_dialog.dart';
import 'package:flutter/material.dart';

class DependencyItemView extends StatelessWidget {
  DependencyInfo info;
  VoidCallback onDelete;
  Function(String name, String version) onEdit;

  DependencyItemView(this.info, this.onDelete, this.onEdit);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    return LayoutBuilder(builder: (context, dimens) {
      double width = dimens.maxWidth;
      return Container(
        width: width,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: width / 4,
                  child: Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Text(this.info.name, style: titleText),
                  ),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Text(this.info.version, style: titleText),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 50),
              child: Row(
                children: [
                  Center(
                      child: TransparentBtn(
                    hoverColor: theme.bg3,
                    contentPadding: EdgeInsets.all(20),
                    onPressed: () {
                      showDeleteTipsDialog(context);
                    },
                    child: Image.asset(
                      "assets/images/ic_delete.png",
                      width: 20,
                      height: 20,
                    ),
                  )),
                  Center(
                      child: TransparentBtn(
                    contentPadding: EdgeInsets.all(20),
                    onPressed: () {
                      showEditDependencyDialog(context);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void showDeleteTipsDialog(BuildContext context) {
    Dialogs.show(OkCancelDialog(
      message: '确定要删除当前依赖？',
      onCancelPressed: () => Navigator.pop(context),
      onOkPressed: () {
        onDelete.call();
        Navigator.pop(context);
      },
    ));
  }

  void showEditDependencyDialog(BuildContext context) {
    Dialogs.show(
        EditDependencyDialog(info.name, info.version, onEditDependency));
  }

  void onEditDependency(String name, String version) {
    onEdit.call(name, version);
  }
}
