import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  String text;
  LoadingDialog(this.text);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(text, style: titleText),
            )
          ],
        ),
      ),
    );
  }
}