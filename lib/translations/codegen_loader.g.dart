// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "welcome_text": "Hi, welcome to Nike App!",
  "something_went_wrong": "Something went wrong!",
  "app_name": "Nike App"
};
static const Map<String,dynamic> fa = {
  "welcome_text": "سلام، به برنامه نایکی خوش آمدید!",
  "something_went_wrong": "خطایی نامشخص رخ داده است!",
  "app_name": "برنامه نایکی"
};
static const Map<String,dynamic> ps = {
  "welcome_text": "سلام، په نایکی برنامه کی شه راغلاست!",
  "something_went_wrong": "یو نامشخص خطا کی رخ کوی!",
  "app_name": "برنامه نایکی"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fa": fa, "ps": ps};
}
