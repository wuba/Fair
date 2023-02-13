import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

///白色边框按钮
class WhiteBorderButtonWidget extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final VoidCallback? onTap;

  WhiteBorderButtonWidget(this.child, this.width, this.height,
      {Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
          borderRadius: Corners.s5Border,
          border: Border.all(color: theme.txt, width: 0.3),
        ),
      ),
    );
  }
}
