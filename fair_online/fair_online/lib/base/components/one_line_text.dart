
import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const OneLineText(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: style, maxLines: 1, softWrap: false, overflow: TextOverflow.fade);
}
