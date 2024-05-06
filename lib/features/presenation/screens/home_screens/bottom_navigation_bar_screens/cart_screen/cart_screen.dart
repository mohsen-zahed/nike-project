import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/images_paths.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';
import 'package:nike_project/features/data/repository/icart_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/bloc/cart_data_fetch_bloc.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/cart_screen/widgets/item_cart_widget.dart';
import 'package:nike_project/features/presenation/screens/initial_screens/registration_screen/registration_screen.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/widgets_common_in_all_screens/app_exception_widget.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_divider_widget.dart';
import 'package:nike_project/widgets_common_in_all_screens/empty_screen_widget.dart';

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
                        ItemCartWidget(
                          itemProduct: itemProduct,
                          index: index,
                          onRemoveItemTap: () {
                            cartBloc?.add(
                              CartRemoveButtonIsClicked(
                                removingItemId: itemProduct[index].cartItemId,
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
                  },
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
