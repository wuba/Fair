import 'package:fair_online/base/components/buttons/primary_btn.dart';
import 'package:fair_online/base/components/buttons/secondary_btn.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/app/styles.dart';
import 'package:flutter/material.dart';

class OkCancelBtnRow extends StatelessWidget {
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;
  final String? okLabel;
  final String? cancelLabel;

  const OkCancelBtnRow(
      {Key? key,
      this.onOkPressed,
      this.onCancelPressed,
      this.okLabel,
      this.cancelLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (onOkPressed != null)
          PrimaryTextBtn(okLabel ?? '确定', onPressed: onOkPressed),
        if (onCancelPressed != null) ...[
          HSpace(Insets.l),
          SecondaryTextBtn(cancelLabel ?? '取消', onPressed: onCancelPressed),
        ]
      ],
    );
  }
}
