import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/data/source/ibanners_repository_remote_source.dart';
import 'package:nike_project/features/data/source/iproducts_repository_remote_source.dart';
import 'package:nike_project/features/presenation/screens/home_screen/bloc/home_bloc.dart';
import 'package:nike_project/features/presenation/screens/home_screen/home_screen.dart';
import 'package:nike_project/packages/dio/dio_package.dart';
import 'package:nike_project/theme/theme.dart';
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
      theme: theme(),
      home: const HomeScreen(),
    );
  }
}
