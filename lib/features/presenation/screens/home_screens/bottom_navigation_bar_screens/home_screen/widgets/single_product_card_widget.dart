import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/product_details_screen/product_details_screen.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_cached_network_image.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';

class SingleProductCardWidget extends StatelessWidget {
  final ProductModel latestProduct;
  final int index;
  final double borderRadius;
  final bool isGridView;
  const SingleProductCardWidget({
    super.key,
    required this.index,
    required this.latestProduct,
    required this.borderRadius,
    required this.isGridView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isGridView
          ? EdgeInsets.zero
          : EdgeInsets.fromLTRB(
              getMediaQueryWidth(context, kDefaultPaddingWidth20),
              0,
              index == 0
                  ? getMediaQueryWidth(context, kDefaultPaddingWidth20)
                  : 0,
              0),
      child: AspectRatio(
        aspectRatio: 0.55,
        child: InkWell(
          overlayColor: const MaterialStatePropertyAll(kTransparentColor),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  product: latestProduct,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: CustomCachedNetworkImage(
                      imageUrl: latestProduct.image,
                      borderRadius: borderRadius,
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
                      horizontal: getMediaQueryWidth(context, 0.025),
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
                    horizontal: getMediaQueryWidth(context, 0.025),
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
                    horizontal: getMediaQueryWidth(context, 0.025),
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
      ),
    );
  }
}
