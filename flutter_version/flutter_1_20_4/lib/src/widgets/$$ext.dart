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
            mouseCursor: props['mouseCursor'],
            focusColor: props['focusColor'],
            hoverColor: props['hoverColor'],
            highlightColor: props['highlightColor'],
            overlayColor: props['overlayColor'],
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
      'Duration': (props) => Duration(
            days: props['days'] ?? 0,
            hours: props['hours'] ?? 0,
            minutes: props['minutes'] ?? 0,
            seconds: props['seconds'] ?? 0,
            milliseconds: props['milliseconds'] ?? 0,
            microseconds: props['microseconds'] ?? 0,
      ),
      'BorderRadius.circular': (props) => BorderRadius.circular(
            props['pa'][0]?.toDouble(),
      ),
      'BottomNavigationBarItem':(props)=>BottomNavigationBarItem(
            icon: props['icon'],
            title: props['title'],
            activeIcon: props['activeIcon'] ?? props['icon'],
            backgroundColor: props['backgroundColor'],
      ),
      'StadiumBorder': (props) => StadiumBorder(
            side:props['side'] ?? BorderSide.none,
      ),
      'RoundedRectangleBorder': (props) => RoundedRectangleBorder(
            side: props['side'] ?? BorderSide.none,
            borderRadius: props['props'] ?? BorderRadius.zero,
      ),
      'ContinuousRectangleBorder': (props) => ContinuousRectangleBorder(
            side: props['side'] ?? BorderSide.none,
            borderRadius: props['props'] ?? BorderRadius.zero,
      ),
      'BeveledRectangleBorder':(props) => BeveledRectangleBorder(
            side: props['side'] ?? BorderSide.none,
            borderRadius: props['props'] ?? BorderRadius.zero,
      ),
      'BoxConstraints': (props) => BoxConstraints(
            minWidth: props['minWidth']?.toDouble() ?? 0.0,
            maxWidth: props['maxWidth']?.toDouble() ?? double.infinity,
            minHeight: props['minHeight']?.toDouble() ?? 0.0,
            maxHeight: props['maxHeight']?.toDouble() ?? double.infinity,
      ),
      // 往下补充Widget映射关系
    };
