import 'package:fair_online/app/styles.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ThemeType {
  LIGHT,
  DARK,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.DARK;

  bool isDark;
  Color bg1;
  Color surface;
  Color bg2;
  Color bg3;
  Color divider;
  Color accent1;
  Color accent1Dark;
  Color accent1Darker;
  Color accent2;
  Color accent3;
  Color grey;
  Color greyStrong;
  Color greyWeak;
  Color error;
  Color focus;

  Color txt;
  Color accentTxt;

  /// Default constructor
  AppTheme({
    required this.isDark,
    required this.bg1,
    required this.surface,
    required this.bg2,
    required this.bg3,
    required this.divider,
    required this.accent1,
    required this.accent1Dark,
    required this.accent1Darker,
    required this.accent2,
    required this.accent3,
    required this.grey,
    required this.greyStrong,
    required this.greyWeak,
    required this.error,
    required this.focus,
    required this.txt,
    required this.accentTxt,
  });

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.LIGHT:
        return AppTheme(
          isDark: false,
          txt: Colors.black,
          accentTxt: Colors.black,
          bg1: Color(0xfff1f7f0),
          bg2: Color(0xffc1dcbc),
          bg3: Color(0xfff1f7f0),
          divider: Colors.white,
          surface: Colors.white,
          accent1: Color(0xff00a086),
          accent1Dark: Color(0xff00856f),
          accent1Darker: Color(0xff006b5a),
          accent2: Color(0xfff09433),
          accent3: Color(0xff5bc91a),
          greyWeak: Color(0xff909f9c),
          grey: Color(0xff515d5a),
          greyStrong: Color(0xff151918),
          error: Colors.red.shade900,
          focus: Color(0xFF0ee2b1),
        );

      case ThemeType.DARK:
        return AppTheme(
          isDark: true,
          txt: Colors.white,
          accentTxt: Colors.white,
          bg1: Color(0xff121212),
          bg2: Color(0xff1f2428),
          bg3: Color(0xff15181B),
          divider: Color(0xff1f2428),
          surface: Color(0xff15181B),
          accent1: Color(0xff00a086),
          accent1Dark: Color(0xff00caa5),
          accent1Darker: Color(0xff00caa5),
          accent2: Color(0xfff19e46),
          accent3: Color(0xff5BC91A),
          greyWeak: Color(0xffa8b3b0),
          grey: Color(0xffced4d3),
          greyStrong: Color(0xffffffff),
          error: Color(0xffe55642),
          focus: Color(0xff0ee2b1),
        );
    }
  }

  ThemeData get themeData {
    return ThemeData(
        colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryContainer: accent1Darker,
          secondary: accent2,
          secondaryContainer: ColorUtils.shiftHsl(accent2, -.2),
          background: bg3,
          surface: surface,
          onBackground: txt,
          onSurface: txt,
          onError: txt,
          onPrimary: accentTxt,
          onSecondary: accentTxt,
          error: error,
        ),
        scaffoldBackgroundColor: bg3,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.noto,
        inputDecorationTheme: InputDecorationTheme(
          border: ThinUnderlineBorder(),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: greyWeak,
          selectionHandleColor: Colors.transparent,
          cursorColor: accent1,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: accent1,
        ),
        highlightColor: accent1,
        toggleableActiveColor: accent1);
  }

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));

  static AppTheme of(BuildContext context) {
    return context.watch<AppTheme>();
  }
}
