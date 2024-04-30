import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/presenation/screens/home_screen/sub_screens/widgets/custom_floating_action_button.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/custom_cached_network_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: getMediaQueryWidth(context, 0.8),
            flexibleSpace: CustomCachedNetworkImage(
              imageUrl: product.image,
              borderRadius: kDefautlVerticalGap20,
            ),
            actions: const [
              Icon(Icons.favorite_outline),
              SizedBox(width: 15),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              product.price.withPriceLabel,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Text(
                    'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا هیچ فشار مخربی رو نمیذاره به پا و زانوهای شما انتقال پیدا کنه.',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.users_comments.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kGreyColor),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          LocaleKeys.leave_a_comment.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: kBlueColor),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: kBlueColor,
                    height: 1000,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}
