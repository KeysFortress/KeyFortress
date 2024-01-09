import 'dart:ui';

import 'package:domain/color_theme.dart';

class RoseGold implements ColorTheme {
  // Primary Colors
  @override
  Color primary100 = const Color(0xFFE8B4B4);
  @override
  Color primary200 = const Color(0xFFC99797);
  @override
  Color primary300 = const Color(0xFF845758);

  // Accent Colors
  @override
  Color accent100 = const Color(0xFFD68C8C);
  @override
  Color accent200 = const Color(0xFF723235);

  // Text Colors
  @override
  Color text100 = const Color(0xFF4C4C4C);
  @override
  Color text200 = const Color(0xFF787878);
  @override
  Color text300 = const Color(0xFFE6F1F5);

  // Background Colors
  @override
  Color background100 = const Color(0xFFF6E5E5);
  @override
  Color background200 = const Color(0xFFECDBDB);
  @override
  Color background300 = const Color(0xFFC3B3B3);
}
