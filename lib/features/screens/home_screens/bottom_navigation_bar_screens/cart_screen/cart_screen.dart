import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/bouncing_effect.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/images_paths.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/bloc/cart_data_fetch_bloc.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/sub_screens/shipping_screen/shipping_screen.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/item_cart_widget.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/refresher_indicator_widget.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/shopping_details_widget.dart';
import 'package:nike_project/features/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/utils/theme_checker.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/app_exception_widget.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_divider_widget.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/custom_floating_action_button.dart';
import 'package:nike_project/widgets_common_in_all_screens/empty_screen_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  CartDataFetchBloc? cartBloc;

  final RefreshController _refreshController = RefreshController();
  StreamSubscription? _refreshStream;

  @override
  void dispose() {
    super.dispose();
    AuthRepositoryImpl.authChangeNotifier.removeListener(() {});
    cartBloc?.close();
    _refreshStream?.cancel();
  }

  @override
  void initState() {
    super.initState();
    AuthRepositoryImpl.authChangeNotifier
        .addListener(authChangedNotifierListener);
  }

  void authChangedNotifierListener() {
    cartBloc?.add(
      CartAuthInfoChanged(
          authInfoModel: AuthRepositoryImpl.authChangeNotifier.value),
    );
  }

  bool showPaymentButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.cart_text.tr(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //* Button to shipping screen...
      floatingActionButton: Visibility(
        visible: showPaymentButton,
        child: CustomFloatingActionButton(
          onPressed: () {
            final state = cartBloc?.state;
            if (state is CartDataFetchSuccess) {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => ShippingScreen(
                    totalPrice: state.cartResponseItems.totalPrice,
                    shippingCost: state.cartResponseItems.shippingCost,
                    payablePrice: state.cartResponseItems.payablePrice,
                  ),
                ),
              );
            }
          },
          widget: Text(
            LocaleKeys.complete_payment_text.tr(),
            style: ThemeChecker.isCurrentThemeLight(context)
                ? Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: kWhiteColor)
                : Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: kPrimaryTextColor),
          ),
        ),
      ),
      body: BlocProvider<CartDataFetchBloc>(
        create: (context) {
          final bloc = CartDataFetchBloc(cartRepository);
          cartBloc = bloc;
          _refreshStream = cartBloc?.stream.listen((state) {
            setState(() {
              showPaymentButton = state is CartDataFetchSuccess;
            });
            if (_refreshController.isRefresh) {
              if (state is CartDataFetchSuccess) {
                _refreshController.refreshCompleted();
              }
            }
          });
          bloc.add(CartDataFetchStarted(
              authInfoModel: AuthRepositoryImpl.authChangeNotifier.value));
          return bloc;
        },
        child: SafeArea(
          child: BlocBuilder<CartDataFetchBloc, CartDataFetchState>(
            builder: (context, state) {
              if (state is CartDataFetchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartDataFetchFailed) {
                return AppExceptionWidget(
                  errorMessage: state.errorMessage.toString(),
                  buttonText: LocaleKeys.try_again.tr(),
                  onPressed: () {},
                );
              } else if (state is CartDataFetchSuccess) {
                return RefresherIndicatorWidget(
                  refreshController: _refreshController,
                  onRefresh: () {
                    cartBloc?.add(
                      CartDataFetchStarted(
                          authInfoModel:
                              AuthRepositoryImpl.authChangeNotifier.value),
                    );
                  },
                  child: ListView.builder(
                    physics: defaultBouncingEffect,
                    itemCount: state.cartResponseItems.cartItems.length + 1,
                    padding: EdgeInsets.only(
                        bottom: getMediaQueryHeight(context, 0.1)),
                    itemBuilder: (context, index) {
                      var itemProduct = state.cartResponseItems.cartItems;
                      //* Column containing Card with Divider widgets vertically...
                      if (index < state.cartResponseItems.cartItems.length) {
                        return Column(
                          children: [
                            //* Entire item card...
                            ItemCartWidget(
                              countWidget: itemProduct[index].countLoading
                                  ? const CupertinoActivityIndicator()
                                  : Text(
                                      itemProduct[index].count.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                              onIncreaseButtonTap: () {
                                cartBloc?.add(IncreaseButtonIsClicked(
                                    cartItemId: itemProduct[index].cartItemId));
                              },
                              onDecreaseButtonTap: () {
                                if (itemProduct[index].count > 1) {
                                  cartBloc?.add(
                                    DecreaseButtonIsClicked(
                                        cartItemId:
                                            itemProduct[index].cartItemId),
                                  );
                                }
                              },
                              itemProduct: itemProduct,
                              index: index,
                              onRemoveItemTap: () {
                                cartBloc?.add(
                                  CartRemoveButtonIsClicked(
                                    removingItemId:
                                        itemProduct[index].cartItemId,
                                  ),
                                );
                              },
                            ),
                            CustomDividerWidget(
                              space: 1,
                              thickness: 7,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .color!
                                  .withOpacity(0.2),
                            ),
                          ],
                        );
                      } else {
                        return ShoppingDetailsWidget(
                          totalPrice: state.cartResponseItems.totalPrice,
                          shippingCost: state.cartResponseItems.shippingCost,
                          payablePrice: state.cartResponseItems.payablePrice,
                        );
                      }
                    },
                  ),
                );
              } else if (state is CartAuthRequested) {
                return EmptyScreenWidget(
                  imagePath: ImagesPaths.authRequiredSvgPath,
                  text: LocaleKeys.login_to_see_cart_items.tr(),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  buttonText: LocaleKeys.login_text.tr(),
                );
              } else if (state is CartEmptyData) {
                return EmptyScreenWidget(
                  imagePath: ImagesPaths.emptyCartSvgPath,
                  text: LocaleKeys.your_cart_is_empty.tr(),
                  onPressed: () {},
                  buttonText: LocaleKeys.add_to_cart.tr(),
                );
              }
              throw "state is not supported";
            },
          ),
        ),
      ),
    );
  }
}
