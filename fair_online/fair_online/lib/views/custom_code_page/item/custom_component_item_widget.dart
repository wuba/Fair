import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/custom_code_page/dialog/create_custom_component_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomComponentItemWidget extends StatelessWidget {
  final CustomComponentInfo info;

  CustomComponentItemWidget(this.info);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    TextStyle descText = TextStyles.T2.textColor(theme.txt).textHeight(1.2);
    return LayoutBuilder(builder: (context, dimens) {
      double width = dimens.maxWidth;
      return Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 50),
        height: 100,
        child: Row(
          children: [
            info.screenshot.isEmpty
                ? Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Image.asset(
                      "assets/images/ic_image_load_failed.png",
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Image.network(
                      info.screenshot,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    width: 200,
                    child: Text(info.name, style: titleText),
                  ),
                  HSpace(20),
                  Expanded(child: Text(info.desc, style: descText)),
                  HSpace(50),
                ],
              ),
            ),
            TransparentBtn(
              hoverColor: theme.bg3,
              contentPadding: EdgeInsets.all(20),
              onPressed: () {
                Dialogs.show(OkCancelDialog(
                  message: '确定要删除当前组件？',
                  onCancelPressed: () => Navigator.pop(context),
                  onOkPressed: () {
                    context
                        .read<CustomCodeModel>()
                        .deleteCodeFile(info.path, 'component');
                    Navigator.pop(context);
                  },
                ));
              },
              child: Image.asset(
                "assets/images/ic_delete.png",
                width: 20,
                height: 20,
              ),
            ),
            TransparentBtn(
              hoverColor: theme.bg3,
              contentPadding: EdgeInsets.all(20),
              onPressed: () {
                _editCustomComponent();
              },
              child: Icon(
                Icons.edit,
                size: 20,
              ),
            )
          ],
        ),
      );
    });
  }

  void _editCustomComponent() {
    Dialogs.show(CreateCustomComponentDialog(
        CustomCodeEditType.modify, SourceType.filePath,
        info: info));
  }
}
