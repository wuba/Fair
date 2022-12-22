import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/fair_logo.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

typedef OnSubmit = void Function(String appId, String bundle, String patchUrl);

class QrCodeDialog extends StatefulWidget {
  OnSubmit onSubmit;

  QrCodeDialog(this.onSubmit);

  @override
  State<StatefulWidget> createState() {
    return QrCodeDialogState();
  }
}

class QrCodeDialogState extends State<QrCodeDialog> {
  String _patchUrl = '';
  String? _message;
  bool _isLoading = true;

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer();
    getQrCode();
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
      double maxWidth = dimens.maxWidth * 0.5;
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
                    HSpace(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('手机扫码预览', style: titleText),
                        VSpace(10),
                        Text.rich(
                            TextSpan(style: TextStyle(height: 1.5), children: [
                          TextSpan(text: '打开 ', style: contentText),
                          TextSpan(
                              text: 'FairPlayground',
                              style: TextStyle(
                                  color: theme.accent1,
                                  fontSize: FontSizes.s14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  decoration: TextDecoration.underline),
                              recognizer: _tapGestureRecognizer
                                ..onTap = () => launch(
                                    'https://github.com/wuba/fairpushy')),
                          TextSpan(
                              text: ' APP，进入Fair 开发者选项，点击扫一扫\n扫描下方二维码，即可预览~',
                              style: contentText.textHeight(2.0)),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VSpace(50),
                      _isLoading
                          ? Container(
                              height: 250,
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : _patchUrl.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: QrImage(
                                    backgroundColor: Colors.white,
                                    foregroundColor: theme.accent1,
                                    data: _patchUrl,
                                    version: QrVersions.auto,
                                    size: 250,
                                    gapless: false,
                                  ),
                                )
                              : Container(
                                  height: 250,
                                  child: Center(
                                    child: Text(_message ?? '网络请求失败，请稍后再试~',
                                        style: titleText),
                                  ),
                                ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(
                            top: 40, left: 20, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StyledCard(
                              bgColor: theme.accent1Darker,
                              align: Alignment.center,
                              onPressed: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 140,
                                child: Center(
                                  child: Text("完成", style: contentText),
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

  Future<void> getQrCode() async {
    try {
      final response = await dartServices
          .getQrCode(CommonRequest())
          .timeout(serviceCallTimeout);
      if (response.result.isNotEmpty) {
        _patchUrl = response.result;
      }
    } catch (e) {
      if (e is ApiRequestError) {
        _patchUrl = '';
        _message = e.message;
      }
      print(e);
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }
}
