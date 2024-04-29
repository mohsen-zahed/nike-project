import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/custom_cached_network_image.dart';

class ProductsCardWidget extends StatelessWidget {
  final List<dynamic> latestProducts;
  final int index;
  const ProductsCardWidget({
    super.key,
    required this.latestProducts,
    required this.index,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: getMediaQueryWidth(context),
                child: CustomCachedNetworkImage(
                  list: latestProducts,
                  index: index,
                  borderRadius: 10,
                ),
              ),
              Positioned(
                  top: 2,
                  right: 3,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_outline),
                    onPressed: () {},
                  ))
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: getMediaQueryWidth(context)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getMediaQueryWidth(context, 0.01),
                  vertical: getMediaQueryHeight(context, 0.01)),
              child: Text(
                latestProducts[index].title,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text(
            '${latestProducts[index].previousPrice} تومان',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kGreyColor,
                  decoration: TextDecoration.lineThrough,
                ),
          ),
          Text(
            '${latestProducts[index].price} تومان',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
