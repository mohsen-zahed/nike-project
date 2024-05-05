import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/cart_item_model.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_cached_network_image.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_divider_widget.dart';

class ItemCartWidget extends StatelessWidget {
  final int index;
  final List<CartItemModel> itemProduct;
  const ItemCartWidget({
    super.key,
    required this.itemProduct,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context),
      margin:
          EdgeInsets.all(getMediaQueryWidth(context, kDefaultPaddingWidth20)),
      padding: EdgeInsets.fromLTRB(
          getMediaQueryWidth(context, kDefaultPaddingWidth10),
          getMediaQueryWidth(context, kDefaultPaddingWidth10),
          getMediaQueryWidth(context, kDefaultPaddingWidth10),
          0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius20),
      ),
      child: Column(
        children: [
          //* Horizontal item's image and title...
          Row(
            children: [
              SizedBox(
                height: getMediaQueryHeight(context, 0.13),
                child: CustomCachedNetworkImage(
                    borderRadius: kDefaultTextFieldBorderRadius10,
                    imageUrl: itemProduct[index].product.image),
              ),
              SizedBox(
                  width: getMediaQueryWidth(context, kDefaultPaddingWidth20)),
              Expanded(
                child: Text(
                  itemProduct[index].product.title,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //* Horzontal item's count, count buttons and previous price, price...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(LocaleKeys.count_text.tr()),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.labelSmall!.color!,
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getMediaQueryWidth(
                              context, kDefaultPaddingWidth10),
                        ),
                        child: Text(
                          itemProduct[index].count.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.labelSmall!.color!,
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getMediaQueryWidth(context, 0.2),
                    child: Text(
                      itemProduct[index].product.previousPrice.withPriceLabel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: kCaptionsTextColor,
                          decoration: TextDecoration.lineThrough),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context, 0.2),
                    child: Text(
                      itemProduct[index].product.price.withPriceLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const CustomDividerWidget(space: 5, thickness: 1),
          //* Remove item button...
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getMediaQueryHeight(context, kDefaultPaddingHeight15),
            ),
            child: Text(
              LocaleKeys.remove_from_cart.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
