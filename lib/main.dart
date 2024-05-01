import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/theme/dark_theme.dart';
import 'package:nike_project/theme/light_theme.dart';
import 'package:nike_project/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('fa'),
        Locale('ps'),
      ],
      path: 'assets/translations/',
      fallbackLocale: const Locale('fa'),
      assetLoader: const CodegenLoader(),
      startLocale: const Locale('fa'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      themeMode: ThemeMode.system,
      title: 'Nike App',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const RegistrationScreen(),
    );
  }
}
