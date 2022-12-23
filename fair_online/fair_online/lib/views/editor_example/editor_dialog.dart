import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/models/editor_example_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditorDialog extends StatelessWidget {

  Widget child;

  EditorDialog(this.child);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: EditorExampleModel()),
      ],
      child: LayoutBuilder(builder: (context, dimens) {
        return StyledDialog(
            shrinkWrap: false,
            bgColor: theme.bg2,
            padding: EdgeInsets.all(0),
            maxWidth: dimens.maxWidth * 0.8,
            maxHeight: dimens.maxHeight * 0.8,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: dimens.maxWidth * 0.8,
                height: dimens.maxHeight * 0.8,
                child: child,
              );
            }));
      }),
    );
  }
}
