import 'package:easy_localization/easy_localization.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

extension PriceLabel on int {
  String get withPriceLabel =>
      this > 0 ? '$separateByComma تومان' : LocaleKeys.free_text.tr();
  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
