import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: kWhiteColor,
      ),
      backgroundColor: kSnackbarColor,
      foregroundColor: kWhiteColor,
      centerTitle: true,
      surfaceTintColor: kSnackbarColor,
      elevation: 0.3,
      shadowColor: kGreyColorShade100.withOpacity(0.3),
    ),
    scaffoldBackgroundColor: kPrimaryColor,
    colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: context.locale.languageCode == 'fa'
        ? 'IranYekan'
        : context.locale.languageCode == 'en'
            ? 'IranYekan'
            : 'Noto',
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
      titleLarge: const TextStyle(
        color: kWhiteColor,
      ),
      titleMedium: const TextStyle(
        color: kWhiteColor,
      ),
      titleSmall: const TextStyle(
        color: kCaptionsTextColor,
      ),
      bodyLarge: const TextStyle(
        color: kCaptionsTextColor,
      ),
      bodyMedium: const TextStyle(
        color: kWhiteColor,
      ),
      bodySmall: const TextStyle(
        color: kCaptionsTextColor,
      ),
      labelLarge: const TextStyle(
        color: kPrimaryTextColor,
      ),
      labelMedium: TextStyle(
        color: kGreyColorShade400,
      ),
      labelSmall: const TextStyle(
        color: kCaptionsTextColor,
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
      backgroundColor: kSnackbarColor,
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
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kWhiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: kGreyColorShade400),
      labelStyle: TextStyle(color: kGreyColorShade400),
      suffixIconColor: kGreyColorShade400,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kDefaultTextFieldBorderRadius10),
        ),
        borderSide: BorderSide(
          color: kGreyColorShade400,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kDefaultTextFieldBorderRadius10),
        ),
        borderSide: BorderSide(
          color: kGreyColorShade400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kDefaultTextFieldBorderRadius10),
        ),
        borderSide: BorderSide(
          color: kGreyColorShade400,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: kGreyColorShade400,
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: kSnackbarColor,
      closeIconColor: kWhiteColor,
      showCloseIcon: true,
      contentTextStyle: TextStyle(
        color: kWhiteColor,
        fontFamily: "IranYekan",
      ),
    ),
    dialogBackgroundColor: kSnackbarColor,
    dialogTheme: const DialogTheme(
      surfaceTintColor: kSnackbarColor,
      backgroundColor: kSnackbarColor,
    ),
  );
}
