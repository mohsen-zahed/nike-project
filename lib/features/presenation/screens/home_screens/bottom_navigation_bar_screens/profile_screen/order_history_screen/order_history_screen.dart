import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/repository/iorder_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/profile_screen/order_history_screen/bloc/order_history_bloc.dart';
import 'package:nike_project/functions/theme_checker.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_cached_network_image.dart';
import 'package:nike_project/widgets_common_in_all_screens/default_failed_widget.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderHistoryBloc(orderRepository)..add(OrderHistoryStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.order_history_text.tr()),
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistorySuccess) {
              return ListView.builder(itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                    getMediaQueryWidth(context, kDefaultPaddingWidth20),
                    index == 0 ? getMediaQueryHeight(context, 0.02) : 0,
                    getMediaQueryWidth(context, kDefaultPaddingWidth20),
                    getMediaQueryHeight(context, 0.01),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: getMediaQueryHeight(context, 0.015)),
                  decoration: BoxDecoration(
                    border: Border.all(color: kGreyColorShade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getMediaQueryWidth(context, 0.03)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'شناسه سفارش',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: ThemeChecker.isCurrentThemeLight(
                                            context)
                                        ? kPrimaryTextColor
                                        : kWhiteColor,
                                  ),
                            ),
                            Text(
                              state.orders[index].id.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: ThemeChecker.isCurrentThemeLight(
                                            context)
                                        ? kPrimaryTextColor
                                        : kWhiteColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getMediaQueryWidth(context, 0.03)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.total_price_text.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: ThemeChecker.isCurrentThemeLight(
                                            context)
                                        ? kPrimaryTextColor
                                        : kWhiteColor,
                                  ),
                            ),
                            Text(
                              state.orders[index].payablePrice.withPriceLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: ThemeChecker.isCurrentThemeLight(
                                            context)
                                        ? kPrimaryTextColor
                                        : kWhiteColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      AspectRatio(
                        aspectRatio: 2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.orders[index].products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  getMediaQueryWidth(context, 0.02),
                                  0,
                                  index == 0
                                      ? getMediaQueryWidth(context, 0.02)
                                      : 0,
                                  0),
                              child: CustomCachedNetworkImage(
                                borderRadius: 10,
                                imageUrl:
                                    state.orders[index].products[index].image,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              });
            } else if (state is OrderHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderHistoryFailed) {
              return const DefaultFailedWidget();
            } else {
              return const Center(
                child: Text('Unexpected state'),
              );
            }
          },
        ),
      ),
    );
  }
}