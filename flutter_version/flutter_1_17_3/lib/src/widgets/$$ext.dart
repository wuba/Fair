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
      'BoxDecoration': (props) => BoxDecoration(
            color: props['color'],
            image: props['image'],
            border: props['border'],
            borderRadius: props['borderRadius'],
            boxShadow: props['boxShadow'],
            gradient: props['gradient'],
            backgroundBlendMode: props['backgroundBlendMode'],
            shape: props['shape'] ?? BoxShape.rectangle,
      ),
      'Border': (props) => Border(
            top: props['top'] ?? BorderSide.none,
            right: props['right'] ?? BorderSide.none,
            bottom: props['bottom'] ?? BorderSide.none,
            left: props['left'] ?? BorderSide.none,
      ),
      'BorderSide': (props) => BorderSide(
            color: props['color'] ?? const Color(0xFF000000),
            width: props['width'] ?? 1.0,
            style: props['style'] ?? BorderStyle.solid,),
      'TabController': (props) => TabController(
          length: props['length'],
          vsync: props['vsync'] ?? ScrollableState(),
          initialIndex: props['initialIndex'] ?? 0),
      'TextButton': (props) => TextButton(
            key: props['key'],
            onPressed: props['onPressed'],
            onLongPress: props['onLongPress'],
            style: props['style'],
            focusNode: props['focusNode'],
            autofocus: props['autofocus'] ?? false,
            clipBehavior: props['clipBehavior'] ?? Clip.none,
            child: props['child'],
      ),
      // 往下补充Widget映射关系
};
