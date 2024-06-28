import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';

import 'at_text.dart';
import 'pound_key_text.dart';
import 'emoji_text.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  factory MySpecialTextSpanBuilder() => _mySpecialTextSpanBuilder;
  MySpecialTextSpanBuilder._();
  static final MySpecialTextSpanBuilder _mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder._();

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    if (flag == '') {
      return null;
    }

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, AtText.flag)) {
      return AtText(
        textStyle!,
        onTap,
        start: index! - (AtText.flag.length - 1),
        showAtBackground: false,
      );
    } else if (isStart(flag, EmojiText.flag)) {
      return EmojiText(textStyle!, start: index! - (EmojiText.flag.length - 1));
    } else if (isStart(flag, PoundKeyText.flag)) {
      return PoundKeyText(textStyle!, onTap,
          start: index! - (PoundKeyText.flag.length - 1));
    }
    return null;
  }
}
