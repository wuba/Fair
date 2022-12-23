import 'package:fair_online/app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyledProgressSpinner extends StatelessWidget {
  final Color color;
  final double size;

  const StyledProgressSpinner(
      {Key? key, this.color = Colors.white, this.size = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.accent1Darker),
            backgroundColor: color),
      ),
    );
  }
}
