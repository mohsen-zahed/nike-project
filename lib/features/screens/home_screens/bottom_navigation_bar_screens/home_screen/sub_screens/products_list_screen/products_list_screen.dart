import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/products_list_screen/bloc/products_list_bloc.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/single_product_card_widget.dart';
import 'package:nike_project/utils/theme_checker.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/default_failed_widget.dart';

class ProductsListScreen extends StatefulWidget {
  final int sortNumber;
  const ProductsListScreen({super.key, required this.sortNumber});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

enum ViewType {
  grid,
  list,
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  ProductsListBloc? bloc;
  ViewType viewType = ViewType.grid;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: kTransparentColor,
        title: Text(
          '${LocaleKeys.products_list_text.tr()} - ${LocaleKeys.sport_shoes_text.tr()}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocProvider<ProductsListBloc>(
        create: (context) {
          bloc = ProductsListBloc(productRepository);
          bloc?.add(ProductsListStarted(sort: widget.sortNumber));
          return bloc!;
        },
        child: BlocBuilder<ProductsListBloc, ProductsListState>(
          builder: (context, state) {
            if (state is ProductsListSuccess) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      showSortOptionsBottomSheet(context, state);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeChecker.isCurrentThemeLight(context)
                            ? kWhiteColor
                            : kSnackbarColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .color!
                                .withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getMediaQueryWidth(context, 0.04),
                        vertical: getMediaQueryHeight(context, 0.01),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.sort_down,
                                size: getMediaQueryHeight(context, 0.035),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.sort_text.tr(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    state.sortNames[state.sort],
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                viewType = viewType == ViewType.grid
                                    ? ViewType.list
                                    : ViewType.grid;
                              });
                            },
                            child: Icon(
                              CupertinoIcons.square_grid_2x2,
                              size: getMediaQueryHeight(context, 0.03),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        top: getMediaQueryHeight(context, 0.02),
                        bottom: getMediaQueryHeight(context, 0.02),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ViewType.grid == viewType ? 2 : 1,
                        childAspectRatio:
                            viewType == ViewType.grid ? 0.55 : 0.65,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return SingleProductCardWidget(
                          isGridView: true,
                          borderRadius: 3,
                          index: index,
                          latestProduct: state.products[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProductsListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const DefaultFailedWidget();
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> showSortOptionsBottomSheet(
      BuildContext context, ProductsListSuccess state) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Container(
          width: getMediaQueryWidth(context),
          height: getMediaQueryHeight(context, 0.3),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: ListView.builder(
            itemCount: state.sortNames.length,
            itemBuilder: (context, index) {
              final selectedIndex = state.sort;
              return InkWell(
                onTap: () {
                  bloc?.add(ProductsListStarted(sort: index));
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? themeChecker.isCurrentThemeLight(context)
                              ? kGreyColorShade100.withOpacity(0.5)
                              : kGreyColorShade100.withOpacity(0.1)
                          : Theme.of(context).scaffoldBackgroundColor),
                  padding: EdgeInsets.symmetric(
                      horizontal: getMediaQueryWidth(context, 0.03),
                      vertical: getMediaQueryHeight(context, 0.025)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.sortNames[index],
                      ),
                      selectedIndex == index
                          ? const Icon(Icons.check_circle_outline_outlined)
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
