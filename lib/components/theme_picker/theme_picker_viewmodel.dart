import 'dart:ui';

import 'package:domain/dark_theme.dart';
import 'package:domain/rose_gold_theme.dart';
import 'package:domain/styles.dart';
import 'package:domain/white_theme.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:presentation/page_view_model.dart';

class ThemePickerViewModel extends PageViewModel {
  late IlocalStorage _storage;
  String _themeName = "";
  get themeName => _themeName;

  Color _themeColor = ThemeStyles.theme.accent100;
  get themeColor => _themeColor;

  double _activeTheme = 0;
  get activeTheme => _activeTheme;

  ThemePickerViewModel(super.context);

  ready() async {
    _storage = getIt.get<IlocalStorage>();
    var theme = await _storage.get("theme") as String?;
    if (theme == null) {
      ThemeStyles.theme = WhiteTheme();
      notifyListeners();
      return;
    }

    switch (theme) {
      case "white":
        ThemeStyles.theme = WhiteTheme();
        _activeTheme = 1.0;

        break;
      case "gold":
        ThemeStyles.theme = RoseGold();
        _activeTheme = 1.0;

        break;
      case "dark":
        ThemeStyles.theme = DarkTheme();
        _activeTheme = 2.0;
        break;
    }
    _themeColor = ThemeStyles.theme.accent100;
    notifyListeners();
  }

  void onThemeChanged(double value) {
    _activeTheme = value;
    switch (value) {
      case 0.0:
        ThemeStyles.theme = WhiteTheme();
        _storage.set("theme", "white");
        break;
      case 1.0:
        ThemeStyles.theme = RoseGold();
        _storage.set("theme", "gold");
        break;
      case 2.0:
        ThemeStyles.theme = DarkTheme();
        _storage.set("theme", "dark");
        break;
    }

    _themeColor = ThemeStyles.theme.accent100;
    observer.getObserver("notify_changed", null);
    notifyListeners();
  }
}
