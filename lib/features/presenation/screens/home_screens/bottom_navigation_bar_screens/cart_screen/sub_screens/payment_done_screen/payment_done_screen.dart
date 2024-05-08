import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/payment_done_screen/widgets/two_texts_widgets_horizontally.dart';
import 'package:nike_project/functions/theme_checker.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';

class PaymentDoneScreen extends StatelessWidget {
  final int payablePrice;
  final String nameLastName;
  final String postalCode;
  final String phoneNumber;
  final String address;
  const PaymentDoneScreen(
      {super.key,
      required this.payablePrice,
      required this.nameLastName,
      required this.postalCode,
      required this.phoneNumber,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.payment_bill_text.tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
              vertical: getMediaQueryHeight(context, 0.02)),
          decoration: BoxDecoration(
            border: Border.all(
              color: kGreyColorShade300,
            ),
            borderRadius:
                BorderRadius.circular(kDefaultTextFieldBorderRadius10),
          ),
          padding: EdgeInsets.symmetric(
              vertical: getMediaQueryHeight(context, 0.025)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    getMediaQueryWidth(context, kDefaultPaddingWidth20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.payment_was_made_successfully_text.tr(),
                  style: ThemeChecker.isCurrentThemeLight(context)
                      ? Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: kSecondaryColor)
                      : Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: kWhiteColor),
                ),
                SizedBox(height: getMediaQueryHeight(context, 0.03)),
                TwoTextsWidgetsHorizontally(
                    title: LocaleKeys.order_status_text.tr(),
                    value: LocaleKeys.paid_text.tr()),
                Divider(height: getMediaQueryHeight(context, 0.04)),
                TwoTextsWidgetsHorizontally(
                    title: LocaleKeys.sum_text.tr(),
                    value: payablePrice.withPriceLabel),
                SizedBox(height: getMediaQueryHeight(context, 0.03)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.client_information_text.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: kCaptionsTextColor),
                    ),
                    SizedBox(height: getMediaQueryHeight(context, 0.01)),
                    TwoTextsWidgetsHorizontally(
                        title: LocaleKeys.name_and_last_name_text.tr(),
                        value: nameLastName),
                    SizedBox(height: getMediaQueryHeight(context, 0.01)),
                    TwoTextsWidgetsHorizontally(
                        title: LocaleKeys.postal_code_text.tr(),
                        value: postalCode),
                    SizedBox(height: getMediaQueryHeight(context, 0.01)),
                    TwoTextsWidgetsHorizontally(
                        title: LocaleKeys.phone_number_text.tr(),
                        value: phoneNumber),
                    SizedBox(height: getMediaQueryHeight(context, 0.01)),
                    TwoTextsWidgetsHorizontally(
                        title: LocaleKeys.client_address_text.tr(),
                        value: address),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
