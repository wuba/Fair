import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:fair/fair.dart';
import 'package:fair_version/fair_version.dart';

class AppGeneratedModule extends GeneratedModule {
  @override
  Map<String, dynamic> components() {
    return {
      'BottomNavyBar': (props) => BottomNavyBar(
        key: props['key'],
        selectedIndex: props['selectedIndex'] ?? 0,
        showElevation: props['showElevation'] ?? true,
        iconSize: props['iconSize']?.toDouble() ?? 24,
        backgroundColor: props['backgroundColor'],
        itemCornerRadius: props['itemCornerRadius']?.toDouble() ?? 50,
        containerHeight: props['containerHeight']?.toDouble() ?? 56,
        animationDuration:
        props['animationDuration'] ?? const Duration(milliseconds: 270),
        mainAxisAlignment:
        props['mainAxisAlignment'] ?? MainAxisAlignment.spaceBetween,
        items: List<BottomNavyBarItem>.from(props['items']),
        onItemSelected: props['onItemSelected'],
        curve: props['curve'] ?? Curves.linear,
      ),
      'BottomNavyBar#onItemSelected': (props) => (
          int value,
          ) {
        return (props['block']);
      },
      'BottomNavyBarItem': (props) => BottomNavyBarItem(
        icon: props['icon'],
        title: props['title'],
        activeColor: props['activeColor'] ?? Colors.blue,
        textAlign: props['textAlign'],
        inactiveColor: props['inactiveColor'],
      ),
    };
  }

  @override
  Map<String, bool> mapping() {
    return const {
      'BottomNavyBar': true,
      'BottomNavyBarItem':true,
    };
  }
}
