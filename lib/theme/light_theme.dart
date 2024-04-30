import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(),
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'IranYekan',
    // fontFamilyFallback: const ['Koufiya'],
    primaryColor: kPrimaryColor,

    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(0),
        ),
        splashFactory: NoSplash.splashFactory,
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            color: kWhiteColor,
          ),
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: kGreyColorShade300,
      thickness: 1,
      space: 30,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(kBlackColor),
        overlayColor: MaterialStatePropertyAll(kGreyColorShade400),
      ),
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: kPrimaryTextColor,
      ),
      bodySmall: TextStyle(
        color: kCaptionsTextColor,
        decoration: TextDecoration.lineThrough,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: kWhiteColor,
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
  );
}
