import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/theme/theme.dart';
import 'package:nike_project/translations/codegen_loader.g.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

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
      supportedLocales: const [
        Locale('en'),
        Locale('fa'),
        Locale('ps'),
      ],
      locale: context.locale,
      title: 'Nike App',
      theme: theme(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    productRepository.getAllProducts(0).then((value) {
      debugPrint(value.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.app_name.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.welcome_text.tr(),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(const Locale('en'));
              },
              child: const Text('En'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(const Locale('fa'));
              },
              child: const Text('Fa'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(const Locale('ps'));
              },
              child: const Text('Psfdas'),
            )
          ],
        ),
      ),
    );
  }
}
