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
  "app_name": "Nike App",
  "try_again": "try again!",
  "dio_error_bad_response": "Request failed!",
  "dio_error_connection_error": "Check your connection please!",
  "dio_error_connection_timeout": "Connection failure, check your connection and try again!",
  "dio_error_sent_timeout": "Host not responding, double check and try again!",
  "dio_error_unknown": "Something went wrong!",
  "newest_text": "Latest",
  "see_all_text": "See all",
  "most_viewed_text": "Most viewed"
};
static const Map<String,dynamic> fa = {
  "welcome_text": "سلام، به برنامه نایکی خوش آمدید!",
  "something_went_wrong": "خطایی نامشخص رخ داده است!",
  "app_name": "برنامه نایکی",
  "try_again": "تلاش دوباره!",
  "dio_error_bad_response": "درخواست ناموفق!",
  "dio_error_connection_error": "لطفا اتصال خود را چک کنید!",
  "dio_error_connection_timeout": "خطا در اتصال، اینترنت خود را چک نموده و دوباره امتحان کنید!",
  "dio_error_sent_timeout": "خطایی در اتصال با سرور رخ داده است، دوباره امتحان کنید!",
  "dio_error_unknown": "خطایی نامشخص رخ داده است!",
  "newest_text": "جدیدترین ها",
  "see_all_text": "مشاهده همه",
  "most_viewed_text": "پربازدیدترین ها"
};
static const Map<String,dynamic> ps = {
  "welcome_text": "سلامونه او نیکې هیلې!",
  "something_went_wrong": "یوه ناپېژندلې تېروتنه رامنځته شوه!",
  "app_name": "نیک اپلیکیشن",
  "try_again": "یو ځل بیا هڅه وکړئ",
  "dio_error_bad_response": "ناکامه غوښتنه!",
  "dio_error_connection_error": "مهربانی وکړئ خپل ارتباط وګورئ!",
  "dio_error_connection_timeout": "د نښلولو تېروتنه، خپل انټرنیټ وګورئ او بیا هڅه وکړئ!",
  "dio_error_sent_timeout": "د سرور سره په اړیکه کې یوه تېروتنه پیښه شوې ، بیا هڅه وکړئ!",
  "dio_error_unknown": "یوه ناپېژندلې تېروتنه رامنځته شوه!",
  "newest_text": "وروستی",
  "see_all_text": "ټول وګورئ",
  "most_viewed_text": "ډېرې کتل کېدۍ"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fa": fa, "ps": ps};
}
