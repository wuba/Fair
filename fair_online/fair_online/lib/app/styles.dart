import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

export 'package:textstyle_extensions/textstyle_extensions.dart';

class Durations {
  static const Duration fastest = Duration(milliseconds: 150);

  static const Duration fast = Duration(milliseconds: 250);

  static const Duration medium = Duration(milliseconds: 350);

  static const Duration slow = Duration(milliseconds: 700);
}

class Fonts {
  static const String noto = "NotoSansSC";
}

class PageBreaks {
  static double get LargePhone => 550;

  static double get TabletPortrait => 768;

  static double get TabletLandscape => 1024;

  static double get Desktop => 1440;
}

class Insets {
  static double gutterScale = 1;

  static const double scale = 1;

  /// Dynamic insets, may get scaled with the device size
  static double mGutter = m * gutterScale;

  static double lGutter = l * gutterScale;

  static const double xs = 2 * scale;

  static const double sm = 6 * scale;

  static const double m = 12 * scale;

  static const double l = 24 * scale;

  static const double xl = 36 * scale;
}

class FontSizes {
  static const double scale = 1;

  static const double s11 = 11 * scale;

  static const double s12 = 12 * scale;

  static const double s14 = 14 * scale;

  static const double s16 = 16 * scale;

  static const double s18 = 18 * scale;
}

class Sizes {
  static const double hitScale = 1;

  static const double hit = 40 * hitScale;

  static const double iconMed = 20;

  static const double sideBarSm = 150 * hitScale;

  static const double sideBarMed = 200 * hitScale;

  static const double sideBarLg = 290 * hitScale;
}

class TextStyles {
  static const TextStyle lato = TextStyle(
    fontFamily: Fonts.noto,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1,
    fontFamilyFallback: [
      Fonts.noto,
    ],
  );

  static const TextStyle quicksand = TextStyle(
    fontFamily: Fonts.noto,
    fontWeight: FontWeight.w400,
    fontFamilyFallback: [
      Fonts.noto,
    ],
    decoration: TextDecoration.none
  );

  static TextStyle get T1 => quicksand.bold.size(FontSizes.s14).letterSpace(.7);

  static TextStyle get T2 => lato.bold.size(FontSizes.s12).letterSpace(.4);

  static TextStyle get H1 => lato.bold.size(FontSizes.s14);

  static TextStyle get H2 => lato.bold.size(FontSizes.s12);

  static TextStyle get Body1 => lato.size(FontSizes.s14);

  static TextStyle get Body2 => lato.size(FontSizes.s12);

  static TextStyle get Body3 => lato.size(FontSizes.s11);

  static TextStyle get Callout => quicksand.size(FontSizes.s14).letterSpace(1.75);

  static TextStyle get CalloutFocus => Callout.bold;

  static TextStyle get Btn => quicksand.bold.size(FontSizes.s14).letterSpace(1.75);

  static TextStyle get BtnSelected => quicksand.size(FontSizes.s14).letterSpace(1.75);

  static TextStyle get Footnote => quicksand.bold.size(FontSizes.s11);

  static TextStyle get Caption => lato.size(FontSizes.s11).letterSpace(.3);
}

class Shadows {
  static bool enabled = true;

  static double get mRadius => 8;

  static List<BoxShadow> m(Color color, [ double opacity = 0]) {
    return enabled
        ? [
            BoxShadow(
              color: color.withOpacity(opacity),
              blurRadius: mRadius,
              spreadRadius: mRadius / 2,
              offset: Offset(1, 0),
            ),
            BoxShadow(
              color: color.withOpacity(opacity),
              blurRadius: mRadius / 2,
              spreadRadius: mRadius / 4,
              offset: Offset(1, 0),
            )
          ]
        : const<BoxShadow>[];
  }
}

class Corners {
  static const double btn = s5;

  static const double dialog = 12;

  /// Xs
  static const double s3 = 3;

  static BorderRadius get s3Border => BorderRadius.all(s3Radius);

  static Radius get s3Radius => Radius.circular(s3);

  /// Small
  static const double s5 = 5;

  static BorderRadius get s5Border => BorderRadius.all(s5Radius);

  static Radius get s5Radius => Radius.circular(s5);

  /// Medium
  static const double s8 = 8;

  static const BorderRadius s8Border = BorderRadius.all(s8Radius);

  static const Radius s8Radius = Radius.circular(s8);

  /// Large
  static const double s10 = 10;

  static BorderRadius get s10Border => BorderRadius.all(s10Radius);

  static Radius get s10Radius => Radius.circular(s10);
}

