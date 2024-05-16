import 'package:easy_localization/easy_localization.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

class ProductsSortCons {
  static int priceHighToLow = 2;
  static int priceLowToHigh = 3;
  static int latest = 0;
  static int popular = 1;

  static List<String> sortTypes = [
    LocaleKeys.newest_text.tr(),
    LocaleKeys.most_viewed_text.tr(),
    LocaleKeys.price_high_to_low_text.tr(),
    LocaleKeys.price_low_to_high_text.tr(),
  ];
}
