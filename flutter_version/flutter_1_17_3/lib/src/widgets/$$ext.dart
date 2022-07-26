import 'package:flutter/material.dart';

var p = () => {
      'InkWell': (props) => InkWell(
            key: props['key'],
            child: props['child'],
            onTap: props['onTap'],
            onDoubleTap: props['onDoubleTap'],
            onLongPress: props['onLongPress'],
            onTapDown: props['onTapDown'],
            onTapCancel: props['onTapCancel'],
            onHighlightChanged: props['onHighlightChanged'],
            onHover: props['onHover'],
            focusColor: props['focusColor'],
            hoverColor: props['hoverColor'],
            highlightColor: props['highlightColor'],
            splashColor: props['splashColor'],
            splashFactory: props['splashFactory'],
            radius: props['radius'],
            borderRadius: props['borderRadius'],
            customBorder: props['customBorder'],
            enableFeedback: props['enableFeedback'] ?? true,
            excludeFromSemantics: props['excludeFromSemantics'] ?? false,
            focusNode: props['focusNode'],
            canRequestFocus: props['canRequestFocus'] ?? true,
            onFocusChange: props['onFocusChange'],
            autofocus: props['autofocus'] ?? false,
      ),
      // 往下补充Widget映射关系
};
