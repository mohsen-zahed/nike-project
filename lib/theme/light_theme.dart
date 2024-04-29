import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(),
    brightness: Brightness.light,
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
        color: kBlackColor,
      ),
      bodySmall: TextStyle(
        color: kGreyColorShade600,
      ),
    ),
  );
}
