import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/auth_info_model.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/add_to_cart_screen/bloc/cart_data_fetch_bloc.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/currency_unit_extension.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/app_exception_widget.dart';
import 'package:nike_project/widgets/custom_cached_network_image.dart';
import 'package:nike_project/widgets/custom_divider_widget.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  CartDataFetchBloc? cartBloc;
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

  @override
  void dispose() {
    super.dispose();
    AuthRepositoryImpl.authChangeNotifier.removeListener(() {});
    cartBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartDataFetchBloc>(
      create: (context) {
        final bloc = CartDataFetchBloc(cartRepository);
        cartBloc = bloc;
        bloc.add(CartDataFetchStarted(
            authInfoModel: AuthRepositoryImpl.authChangeNotifier.value));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.cart_text.tr(),
          ),
        ),
        body: SafeArea(
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
                return ListView.builder(
                  itemCount: state.cartResponseItems.cartItems.length,
                  itemBuilder: (context, index) {
                    var itemProduct = state.cartResponseItems.cartItems;
                    //* Column containing Card with Divider widgets vertically...
                    return Column(
                      children: [
                        //* Entire item card...
                        Container(
                          width: getMediaQueryWidth(context),
                          margin: EdgeInsets.all(getMediaQueryWidth(
                              context, kDefaultPaddingWidth20)),
                          padding: EdgeInsets.fromLTRB(
                              getMediaQueryWidth(
                                  context, kDefaultPaddingWidth10),
                              getMediaQueryWidth(
                                  context, kDefaultPaddingWidth10),
                              getMediaQueryWidth(
                                  context, kDefaultPaddingWidth10),
                              0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(kDefaultBorderRadius20),
                          ),
                          child: Column(
                            children: [
                              //* Horizontal item's image and title...
                              Row(
                                children: [
                                  SizedBox(
                                    height: getMediaQueryHeight(context, 0.13),
                                    child: CustomCachedNetworkImage(
                                        borderRadius:
                                            kDefaultTextFieldBorderRadius10,
                                        imageUrl:
                                            itemProduct[index].product.image),
                                  ),
                                  SizedBox(
                                      width: getMediaQueryWidth(
                                          context, kDefaultPaddingWidth20)),
                                  Expanded(
                                    child: Text(
                                      itemProduct[index].product.title,
                                      maxLines: 5,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              //* Horzontal item's count, count buttons and previous price, price...
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(LocaleKeys.count_text.tr()),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: const Center(
                                              child: Icon(Icons.add),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .color!,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: getMediaQueryWidth(
                                                  context,
                                                  kDefaultPaddingWidth10),
                                            ),
                                            child: Text(
                                              itemProduct[index]
                                                  .count
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                          Container(
                                            child: const Center(
                                              child: Icon(Icons.remove),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .color!,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: getMediaQueryWidth(context, 0.2),
                                        child: Text(
                                          itemProduct[index]
                                              .product
                                              .previousPrice
                                              .withPriceLabel,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: kCaptionsTextColor,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: getMediaQueryWidth(context, 0.2),
                                        child: Text(
                                          itemProduct[index]
                                              .product
                                              .price
                                              .withPriceLabel,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
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
                                  vertical: getMediaQueryHeight(
                                      context, kDefaultPaddingHeight15),
                                ),
                                child: Text(
                                  LocaleKeys.remove_from_cart.tr(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
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
                  },
                );
              } else if (state is CartAuthRequested) {
                return AppExceptionWidget(
                  errorMessage: LocaleKeys.login_to_account_text.tr(),
                  buttonText: LocaleKeys.login_text.tr(),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()),
                    );
                  },
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
