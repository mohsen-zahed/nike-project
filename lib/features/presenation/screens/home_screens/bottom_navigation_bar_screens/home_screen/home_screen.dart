import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/images_paths.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/core/exception/app_exception.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/bloc/home_bloc.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/banner_slider_widget.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/card_title_and_see_all_texts.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/horizontal_list_view_builder.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/app_exception_widget.dart';
import 'package:nike_project/widgets/nike_image_widget.dart';

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
                        imagePath: ImagesPaths.darkAppLogo,
                        height: getMediaQueryHeight(context, 0.1),
                      );
                    case 2:
                      //! top banner slider
                      return BannerSliderWidget(
                        banners: state.banners,
                        borderRadius: kDefaultBorderRadius20,
                      );

                    case 3:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //* latest and seeAll widgets...
                          CardTitleAndSeeAllTexts(
                            title: LocaleKeys.newest_text.tr(),
                            onTap: () {},
                          ),
                          //* latest horizontal scrolling list...
                          HorizontalListViewBuilder(
                            listViewBuilderlist: state.latestProducts,
                          ),
                          SizedBox(height: kDefautlVerticalGap20),
                          //* popular and seeAll widgets...
                          CardTitleAndSeeAllTexts(
                            title: LocaleKeys.most_viewed_text.tr(),
                            onTap: () {},
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
              throw AppException(errorException: 'state is not provided.');
            }
          },
        ),
      ),
    );
  }
}
