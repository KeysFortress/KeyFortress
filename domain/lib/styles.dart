import 'package:domain/color_theme.dart';
import 'package:domain/white_theme.dart';
import 'package:flutter/material.dart';

class ThemeStyles {
  static double? width;
  static double? height;
  static ColorTheme theme = WhiteTheme();

  static TextStyle regularHeading = TextStyle(
    color: theme.primary100,
    letterSpacing: 2,
    fontSize: width != null ? 20 : 18,
    fontFamily: "Loto",
    fontWeight: FontWeight.w500,
  );

  static TextStyle regularParagraph = TextStyle(
    color: theme.primary200,
    fontSize: width != null ? 14 : 12,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteParagraph = TextStyle(
    color: theme.primary200,
    fontSize: width != null ? 14 : 12,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w400,
  );

  static TextStyle regularInnerHeading = TextStyle(
    color: theme.primary200,
    fontSize: 18,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w500,
  );

  static var darkBtnSolid = Color(0xFF151515);

  // Overrides
  static TextStyle regularParagraphOv({
    Color color = const Color(0xFFE0E0E0),
    double? lineSpacing,
    double? size,
    FontWeight? weight,
    TextDecoration? decoration,
    double scaleFactor = 2,
    bool scaleOnFactor = false,
  }) {
    if (width != null && width! <= 360) {
      switch (scaleOnFactor) {
        case true:
          return TextStyle(
            color: color,
            fontSize: size != null ? size / scaleFactor : 10,
            height: lineSpacing,
            letterSpacing: 2,
            fontFamily: "Loto",
            fontWeight: weight ?? FontWeight.w400,
            decoration: decoration,
            decorationColor: color,
          );

        case false:
          return TextStyle(
            color: color,
            fontSize: size != null ? size - 2 : 10,
            height: lineSpacing,
            letterSpacing: 2,
            fontFamily: "Loto",
            fontWeight: weight ?? FontWeight.w400,
            decoration: decoration,
            decorationColor: color,
          );
      }
    } else {
      return TextStyle(
        color: color,
        fontSize: size ?? 12,
        height: lineSpacing,
        letterSpacing: 2,
        fontFamily: "Loto",
        fontWeight: weight ?? FontWeight.w400,
        decoration: decoration,
        decorationColor: color,
      );
    }
  }

  static TextStyle innerHeadingOv({
    Color color = const Color(0xFFFFFFFF),
    double? lineSpacing,
    double? letterSpacing,
    FontWeight? weight,
    double? fontSize,
  }) {
    if (width != null && width! <= 360) {
      return TextStyle(
        color: color,
        fontSize: fontSize != null ? fontSize - 2 : 16,
        height: lineSpacing,
        letterSpacing: letterSpacing ?? 2,
        fontFamily: "Loto",
        fontWeight: weight ?? FontWeight.w400,
      );
    } else {
      return TextStyle(
        color: color,
        fontSize: fontSize ?? 18,
        height: lineSpacing,
        letterSpacing: letterSpacing ?? 2,
        fontFamily: "Loto",
        fontWeight: weight ?? FontWeight.w400,
      );
    }
  }

  static double adjustDistanceReverse(
      BuildContext context, double scaleFactor) {
    return MediaQuery.of(context).size.width <= 360 ? 3.5 : scaleFactor;
  }

  static double adjustDistance(BuildContext context, double scaleFactor) {
    return MediaQuery.of(context).size.width <= 360
        ? scaleFactor / 2
        : scaleFactor;
  }

  static double adjustDistanceHeight(BuildContext context, double scaleFactor) {
    var height = MediaQuery.of(context).size.height <= 900
        ? scaleFactor / 4
        : scaleFactor;

    return height;
  }
}
