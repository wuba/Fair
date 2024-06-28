// ignore_for_file: depend_on_referenced_packages

import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PoundKeyText extends SpecialText {
  PoundKeyText(TextStyle? textStyle, SpecialTextGestureTapCallback? onTap,
      {this.start})
      : super(flag, flag, textStyle, onTap: onTap);
  static const String flag = '#';
  final int? start;
  @override
  InlineSpan finishText() {
    final String text = getContent();

    return SpecialTextSpan(
        text: text,
        actualText: toString(),
        start: start!,

        ///caret can move into special text
        deleteAll: true,
        style: textStyle?.copyWith(color: Colors.orange),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap!(toString());
            }
          });
  }
}
