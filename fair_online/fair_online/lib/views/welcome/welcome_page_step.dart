import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/buttons/primary_btn.dart';
import 'package:fair_online/base/components/seperated_flexibles.dart';
import 'package:fair_online/app/styles.dart';
import 'package:fair_online/views/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePageStep extends StatelessWidget {
  const WelcomePageStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomePageState state = context.watch();
    TextStyle bodyTxtStyle =
        TextStyles.Body1.textColor(Color(0xfff1f7f0)).textHeight(1.6);
    return SeparatedColumn(
      separatorBuilder: () => SizedBox(height: Insets.l),
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        [
          Text(
            "欢迎使用Fair云开发平台",
            style:
                TextStyles.CalloutFocus.bold.size(24).textColor(Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            "Fair云开发平台，提供可视化在线平台，所见即所得，开发者无需配置Flutter/Fair开发环境，即可实现代码在线编辑，云端实时编译预览，一键打包发布一体化的Flutter动态化解决方案。",
            style: bodyTxtStyle,
            textAlign: TextAlign.center,
          ).padding(vertical: Insets.l),
          Text(
            "Fair是为Flutter设计的动态化框架，通过Fair Compiler工具对原生Dart源文件的自动转化，使项目获得动态更新Widget Tree和State的能力。",
            style: bodyTxtStyle,
            textAlign: TextAlign.center,
          ),
        ].toColumn().constrained(maxWidth: 400),
        PrimaryTextBtn(
          "开始使用",
          bigMode: true,
          onPressed: state.handleStartPressed,
        ).padding(top: Insets.m).width(239),
      ],
    ).padding(vertical: Insets.l);
  }
}
