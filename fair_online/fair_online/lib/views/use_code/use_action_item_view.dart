import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/views/use_code/use_code_list_page.dart';
import 'package:flutter/material.dart';

class UseActionItemView extends StatelessWidget {
  CustomActionInfo customActionInfo;
  UseCodeListPageState state;
  int length;
  int index;

  UseActionItemView(this.customActionInfo, this.state, this.length, this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth;
      AppTheme theme = AppTheme.of(context);
      TextStyle titleText = TextStyles.T1.textColor(theme.txt);
      return Container(
        width: maxWidth,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              width: maxWidth / 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  customActionInfo.name,
                  style: titleText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                child: TransparentBtn(
                  onPressed: () {
                    state.showUseCustomActionDialog(customActionInfo);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.accent1Darker,
                        border: Border.all(color: theme.divider, width: 3)),
                    child: Center(
                      child: Text(
                        '使用',
                        style: TextStyles.Body3.textColor(theme.txt),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }
}
