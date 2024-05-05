import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/product_details_screen/bloc/product_add_to_cart_bloc.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/product_details_screen/comments/comments_list_widget.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/product_details_screen/widgets/custom_floating_action_button.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_cached_network_image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductAddToCartState>? streamSubscription;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProductAddToCartBloc(iCartRepository: cartRepository);
        streamSubscription = bloc.stream.listen((state) {
          if (state is ProductAddToCartSuccess) {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text(LocaleKeys.item_added_to_cart_successfully.tr()),
            ));
          } else if (state is ProductAddToCartFailed) {
            _scaffoldKey.currentState?.showSnackBar(
              SnackBar(content: Text(state.errorMessage.toString())),
            );
          }
        });
        return bloc;
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius20),
                ),
                expandedHeight: getMediaQueryWidth(context, 0.8),
                flexibleSpace: CustomCachedNetworkImage(
                  imageUrl: widget.product.image,
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
                    horizontal:
                        getMediaQueryWidth(context, kDefaultPaddingWidth20),
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
                              widget.product.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: kCaptionsTextColor,
                                          decoration:
                                              TextDecoration.lineThrough),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  widget.product.price.withPriceLabel,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(height: 1.8),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.users_comments.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: kGreyColor),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              LocaleKeys.leave_a_comment.tr(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommentsListWidget(productId: widget.product.id),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              BlocBuilder<ProductAddToCartBloc, ProductAddToCartState>(
            builder: (context, state) {
              return CustomFloatingActionButton(
                widget: state is ProductAddToCartLoading
                    ? const CupertinoActivityIndicator()
                    : Text(
                        LocaleKeys.add_to_cart.tr(),
                      ),
                onPressed: () {
                  BlocProvider.of<ProductAddToCartBloc>(context).add(
                    CartAddToCartButtonIsClicked(productId: widget.product.id),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
