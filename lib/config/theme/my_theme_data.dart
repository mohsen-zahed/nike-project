import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/numeric_contants.dart';

class MyThemeData {
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

  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        foregroundColor: kPrimaryTextColor,
        toolbarTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        surfaceTintColor: kWhiteColor,
        elevation: 1,
        shadowColor: kGreyColorShade100.withOpacity(0.3),
      ),
      scaffoldBackgroundColor: kWhiteColor,
      colorScheme: const ColorScheme.light(),
      brightness: Brightness.light,
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
      dialogBackgroundColor: kWhiteColor,
      dialogTheme: const DialogTheme(
        surfaceTintColor: kWhiteColor,
        backgroundColor: kWhiteColor,
      ),
    );
  }
}

final MyThemeData myThemeData = MyThemeData();
