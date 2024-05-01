import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
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
            color: kRedColor,
          ),
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: kGreyColorShade700,
      thickness: 1,
      space: 30,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(kBlackColor),
        overlayColor: MaterialStatePropertyAll(kGreyColorShade400),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
        color: kWhiteColor,
      ),
      bodySmall: const TextStyle(
        color: kCaptionsTextColor,
      ),
      titleLarge: const TextStyle(
        color: kWhiteColor,
      ),
      titleMedium: const TextStyle(
        color: kWhiteColor,
      ),
      titleSmall: const TextStyle(
        color: kCaptionsTextColor,
      ),
      labelLarge: const TextStyle(),
      labelMedium: TextStyle(
        color: kGreyColorShade400,
      ),
      labelSmall: const TextStyle(
        color: kCaptionsTextColor,
        decoration: TextDecoration.lineThrough,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: kPrimaryTextColor,
      backgroundColor: kWhiteColor,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(kPrimaryTextColor),
        backgroundColor: MaterialStatePropertyAll(kWhiteColor),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: kWhiteColor,
      ),
      selectedItemColor: kWhiteColor,
      selectedLabelStyle: TextStyle(color: kWhiteColor),
      unselectedIconTheme: IconThemeData(
        color: kGreyColor,
      ),
      unselectedItemColor: kGreyColor,
      unselectedLabelStyle: TextStyle(color: kGreyColor),
    ),
  );
}
