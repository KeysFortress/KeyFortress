import 'dart:ui';

import 'package:domain/color_theme.dart';

class DarkTheme implements ColorTheme {
  // Primary Colors
  @override
  Color primary100 = const Color(0xFFB76E79);
  @override
  Color primary200 = const Color(0xFFEB9DA8);
  @override
  Color primary300 = const Color(0xFFFFFFFF);

  // Accent Colors
  @override
  Color accent100 = const Color(0xFFD4AF37);
  @override
  Color accent200 = const Color(0xFF6C5400);

  // Text Colors
  @override
  Color text100 = const Color(0xFFFFFFFF);
  @override
  Color text200 = const Color(0xFFE0E0E0);
  @override
  Color text300 = const Color(0xFF000000);

  // Background Colors
  @override
  Color background100 = const Color(0xFF1A1A1A);
  @override
  Color background200 = const Color(0xFF292929);
  @override
  Color background300 = const Color(0xFF404040);
}
