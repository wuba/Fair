import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/fair_logo.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

typedef OnSubmit = void Function(String appId, String bundle, String patchUrl);

class UploadPluginDialog extends StatefulWidget {
  OnSubmit onSubmit;

  UploadPluginDialog(this.onSubmit);

  @override
  State<StatefulWidget> createState() {
    return UploadPluginDialogState();
  }
}

class UploadPluginDialogState extends State<UploadPluginDialog> {
  String appId = '';
  String bundleName = '';
  String patchUrl = '';

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    TextStyle contentText = TextStyles.T2.textColor(theme.txt);
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth * 0.7;
      return StyledDialog(
        shrinkWrap: false,
        bgColor: theme.bg2,
        padding: EdgeInsets.all(0),
        maxWidth: maxWidth,
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    FairLogo(120, theme.accent1Darker),
                    HSpace(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('上传补丁', style: titleText),
                        VSpace(10),
                        Text.rich(TextSpan(children: [
                          TextSpan(text: '还没有热更新平台? 快去看看 ', style: contentText),
                          TextSpan(
                              text: 'FairPushy',
                              style: TextStyle(
                                  color: theme.accent1,
                                  fontSize: FontSizes.s14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7,
                                  decoration: TextDecoration.underline),
                              recognizer: _tapGestureRecognizer
                                ..onTap = () => launch(
                                    'https://github.com/wuba/fairpushy')),
                          TextSpan(text: ' 吧~', style: contentText),
                        ])),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: maxWidth,
                color: theme.bg1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, left: 50),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                "AppId : ",
                                style: titleText,
                              ),
                            ),
                            Container(
                              width: 400,
                              child: buildTextInput(
                                  context, "请输入对应app id", null, (value) {
                                //文字改变
                                appId = value;
                              },
                                  autoFocus: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Insets.l * 0.8,
                                      horizontal: Insets.l * 0.8)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 50),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                "BundleName : ",
                                style: titleText,
                              ),
                            ),
                            Container(
                              width: 400,
                              child: buildTextInput(context, "请输入补丁名称", null,
                                  (value) {
                                //文字改变
                                bundleName = value;
                              },
                                  autoFocus: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Insets.l * 0.8,
                                      horizontal: Insets.l * 0.8)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 50),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                "PatchUrl : ",
                                style: titleText,
                              ),
                            ),
                            Container(
                              width: 400,
                              child: buildTextInput(context, "请输入补丁服务器地址", null,
                                  (value) {
                                //文字改变
                                patchUrl = value;
                              },
                                  autoFocus: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Insets.l * 0.8,
                                      horizontal: Insets.l * 0.8)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(
                            top: 40, left: 20, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: StyledCard(
                                bgColor: theme.accent1Darker,
                                align: Alignment.center,
                                onPressed: () => cancel(),
                                child: Container(
                                  width: 140,
                                  child: Center(
                                    child: Text("取消", style: contentText),
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.only(right: 30),
                            ),
                            StyledCard(
                              bgColor: theme.accent1Darker,
                              align: Alignment.center,
                              onPressed: () => ok(
                                  appId: appId,
                                  bundleName: bundleName,
                                  patchUrl: patchUrl),
                              child: Container(
                                width: 140,
                                child: Center(
                                  child: Text("确定", style: contentText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildTextInput(BuildContext context, String hint, String? initial,
      void Function(String)? onChanged,
      {bool autoFocus = false,
      EdgeInsets padding = StyledFormTextInput.kDefaultTextInputPadding,
      int? maxLines = 1,
      TextEditingController? controller}) {
    return StyledFormTextInput(
        controller: controller,
        hintText: hint,
        contentPadding: padding,
        autoFocus: autoFocus,
        initialValue: initial,
        maxLines: maxLines,
        textStyle: TextStyles.Body1.size(FontSizes.s14),
        onChanged: onChanged);
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void ok(
      {required String appId,
      required String bundleName,
      required String patchUrl}) {
    if (appId.isEmpty) {
      Dialogs.show(ToastDialog(title: "", message: "请输入AppId"));
      return;
    }
    if (bundleName.isEmpty) {
      Dialogs.show(ToastDialog(title: "", message: "请输入BundleName"));
      return;
    }
    if (patchUrl.isEmpty) {
      Dialogs.show(ToastDialog(title: "", message: "请输入PatchUrl"));
      return;
    }
    widget.onSubmit.call(appId, bundleName, patchUrl);
    Navigator.of(context).pop();
  }
}
