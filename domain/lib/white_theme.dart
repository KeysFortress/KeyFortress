import 'dart:ui';

import 'package:domain/color_theme.dart';

class WhiteTheme implements ColorTheme {
  // Primary Colors
  @override
  Color primary100 = const Color(0xFF4DA8C0);
  @override
  Color primary200 = const Color(0xFF288ba3);
  @override
  Color primary300 = const Color(0xFF004d62);

  // Accent Colors
  @override
  Color accent100 = const Color(0xFF8FD1E0);
  @override
  Color accent200 = const Color(0xFF2b717f);

  // Text Colors
  @override
  Color text100 = const Color(0xFF0d0d0d);
  @override
  Color text300 = const Color(0xFFE6F1F5);
  @override
  Color text200 = const Color(0xFFdce7eb);

  // Background Colors
  @override
  Color background100 = const Color(0xFFE6F1F5);
  @override
  Color background200 = const Color(0xFFdce7eb);
  @override
  Color background300 = const Color(0xFFb4bec2);
}
