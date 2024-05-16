import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/numeric_contants.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/two_horizontal_widgets.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';

class ShoppingDetailsWidget extends StatelessWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;
  const ShoppingDetailsWidget({
    super.key,
    required this.totalPrice,
    required this.shippingCost,
    required this.payablePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
            vertical: getMediaQueryHeight(context, kDefaultPaddingHeight15),
          ),
          child: Text(
            LocaleKeys.shopping_details_text.tr(),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kCaptionsTextColor),
          ),
        ),
        TwoHorzontalWidgets(
          text: LocaleKeys.total_price_text.tr(),
          value: totalPrice.separateByComma,
          isGreyApplied: true,
        ),
        TwoHorzontalWidgets(
          text: LocaleKeys.shipping_cost_text.tr(),
          value: shippingCost.separateByComma,
          isGreyApplied: false,
        ),
        TwoHorzontalWidgets(
          text: LocaleKeys.payable_price_text.tr(),
          value: payablePrice.separateByComma,
          isGreyApplied: false,
        ),
      ],
    );
  }
}
