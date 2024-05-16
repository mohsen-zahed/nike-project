import 'package:flutter/material.dart';

class ThemeChecker {
  static ThemeChecker? _themeChecker;
  ThemeChecker._();
  static ThemeChecker get instance {
    _themeChecker ??= ThemeChecker._();
    return _themeChecker!;
  }

  bool isCurrentThemeLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
}

final ThemeChecker themeChecker = ThemeChecker.instance;
