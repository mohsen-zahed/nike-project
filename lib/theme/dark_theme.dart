import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'IranYekan',
    // fontFamilyFallback: const ['Koufiya'],
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            color: kWhiteColor,
          ),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
        color: kWhiteColor,
      ),
      bodySmall: TextStyle(
        color: kGreyColorShade300,
      ),
    ),
  );
}
