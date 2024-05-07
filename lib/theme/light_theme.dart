import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';

ThemeData lightTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: kPrimaryColor,
      ),
      backgroundColor: kWhiteColor,
      foregroundColor: kPrimaryTextColor,
      centerTitle: true,
      surfaceTintColor: kWhiteColor,
      elevation: 0.3,
      shadowColor: kGreyColorShade100.withOpacity(0.3),
    ),

    scaffoldBackgroundColor: kWhiteColor,
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
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(kBlackColor),
        overlayColor: MaterialStatePropertyAll(kGreyColorShade400),
      ),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: kPrimaryTextColor,
      ),
      titleMedium: TextStyle(
        color: kPrimaryTextColor,
      ),
      titleSmall: TextStyle(
        color: kSecondaryColor,
      ),
      bodyLarge: TextStyle(
        color: kCaptionsTextColor,
      ),
      bodyMedium: TextStyle(
        color: kPrimaryTextColor,
      ),
      bodySmall: TextStyle(
        color: kCaptionsTextColor,
      ),
      labelLarge: TextStyle(
        color: kWhiteColor,
      ),
      labelMedium: TextStyle(
        color: kCaptionsTextColor,
      ),
      labelSmall: TextStyle(
        color: kCaptionsTextColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: kWhiteColor,
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(kWhiteColor),
        backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kWhiteColor,
      selectedIconTheme: IconThemeData(
        color: kBlueColor,
      ),
      selectedItemColor: kBlueColor,
      selectedLabelStyle: TextStyle(color: kBlueColor),
      unselectedIconTheme: IconThemeData(
        color: kGreyColor,
      ),
      unselectedItemColor: kGreyColor,
      unselectedLabelStyle: TextStyle(color: kGreyColor),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kBlueColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: kGreyColorShade400),
      labelStyle: TextStyle(color: kGreyColorShade400),
      suffixIconColor: kGreyColorShade400,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kDefaultTextFieldBorderRadius10),
        ),
        borderSide: const BorderSide(
          color: kWhiteColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kDefaultTextFieldBorderRadius10),
        ),
        borderSide: const BorderSide(
          color: kWhiteColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kDefaultTextFieldBorderRadius10),
          ),
          borderSide: const BorderSide(
            color: kWhiteColor,
          )),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
        color: kWhiteColor,
      )),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: kSecondaryColor,
      closeIconColor: kWhiteColor,
      showCloseIcon: true,
      contentTextStyle: TextStyle(
        color: kWhiteColor,
        fontFamily: "IranYekan",
      ),
    ),
  );
}
