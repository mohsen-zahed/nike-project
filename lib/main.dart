import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/config/theme/my_theme_data.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/screens/home_screens/main_home_screen.dart';
import 'package:nike_project/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  authRepository.loadAuthInfo();
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
      title: 'Nike App',
      themeMode: ThemeMode.system,
      theme: myThemeData.lightTheme(context),
      darkTheme: myThemeData.darkTheme(context),
      home: const MainHomeScreen(),
    );
  }
}
