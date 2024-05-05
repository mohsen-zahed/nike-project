import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_cached_network_image.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';

class SingleProductCardWidget extends StatelessWidget {
  final ProductModel latestProduct;
  final VoidCallback onSingleProductTap;
  final int index;
  const SingleProductCardWidget({
    super.key,
    required this.index,
    required this.onSingleProductTap,
    required this.latestProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context, 0.5),
      margin: EdgeInsets.fromLTRB(
          getMediaQueryWidth(context, kDefaultPaddingWidth20),
          0,
          index == 0 ? getMediaQueryWidth(context, kDefaultPaddingWidth20) : 0,
          0),
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(kTransparentColor),
        borderRadius: BorderRadius.circular(kDefaultBorderRadius20),
        onTap: onSingleProductTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: getMediaQueryWidth(context),
                  child: CustomCachedNetworkImage(
                    imageUrl: latestProduct.image,
                    borderRadius: 10,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 3,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_outline),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: getMediaQueryWidth(context)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getMediaQueryWidth(context, 0.01),
                    vertical: getMediaQueryHeight(context, 0.01)),
                child: Text(
                  latestProduct.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: getMediaQueryWidth(context)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getMediaQueryWidth(context, 0.01),
                ),
                child: Text(
                  latestProduct.previousPrice.withPriceLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: kGreyColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: getMediaQueryWidth(context)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getMediaQueryWidth(context, 0.01),
                ),
                child: Text(
                  latestProduct.price.withPriceLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
