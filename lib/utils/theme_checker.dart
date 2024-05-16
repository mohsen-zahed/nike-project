import 'package:flutter/material.dart';

class ThemeChecker {
  static bool isCurrentThemeLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
}
