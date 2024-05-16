import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/config/constants/images_paths.dart';
import 'package:nike_project/config/constants/products_sort_cons.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/bloc/home_bloc.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/products_list_screen/products_list_screen.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/banner_slider_widget.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/card_title_and_see_all_texts.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/horizontal_list_view_builder.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/app_exception_widget.dart';
import 'package:nike_project/widgets_common_in_all_screens/default_failed_widget.dart';
import 'package:nike_project/widgets_common_in_all_screens/nike_image_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productsBloc = HomeBloc(
          iBannersRepository: bannerRepository,
          iProductsRepository: productRepository,
        );
        productsBloc.add(HomeStarted());
        return productsBloc;
      },
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return NikeImageWidget(
                        imagePath: ImagesPaths.darkAppLogoPath,
                        height: getMediaQueryHeight(context, 0.1),
                      );
                    case 2:
                      //! top banner slider
                      return BannerSliderWidget(
                        banners: state.banners,
                        borderRadius: constantVariables.kDefaultBorderRadius20,
                      );
                    case 3:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //* latest and seeAll widgets...
                          CardTitleAndSeeAllTexts(
                            title: LocaleKeys.newest_text.tr(),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductsListScreen(
                                    sortNumber: ProductsSortCons.latest,
                                  ),
                                ),
                              );
                            },
                          ),
                          //* latest horizontal scrolling list...
                          HorizontalListViewBuilder(
                            listViewBuilderlist: state.latestProducts,
                          ),
                          SizedBox(height: constantVariables.kDefautlVerticalGap20),
                          //* popular and seeAll widgets...
                          CardTitleAndSeeAllTexts(
                            title: LocaleKeys.most_viewed_text.tr(),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductsListScreen(
                                    sortNumber: ProductsSortCons.popular,
                                  ),
                                ),
                              );
                            },
                          ),
                          //* popular horizontal scrolling list...
                          HorizontalListViewBuilder(
                            listViewBuilderlist: state.popularProducts,
                          ),
                        ],
                      );
                    default:
                      return Container(
                        color: Colors.black,
                      );
                  }
                },
              );
            } else if (state is HomeFailed) {
              return AppExceptionWidget(
                errorMessage: state.errorMessage,
                buttonText: LocaleKeys.try_again.tr(),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                },
              );
            } else if (state is HomeLoading) {
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
}
