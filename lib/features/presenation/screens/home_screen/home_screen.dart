import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/images_paths.dart';
import 'package:nike_project/core/exception/app_exception.dart';
import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screen/bloc/home_bloc.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';

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
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                          ImagesPaths.appLogo,
                          height: getMediaQueryHeight(context, 0.1),
                        );
                      case 2:
                        return BannersSliderWidget(
                          banners: state.banners,
                        );
                      default:
                        return Container(
                          color: Colors.black,
                        );
                    }
                  },
                );
              } else if (state is HomeFailed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage),
                      SizedBox(
                        height: getMediaQueryHeight(context, 0.02),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: Text(
                          LocaleKeys.try_again.tr(),
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}

class BannersSliderWidget extends StatelessWidget {
  final List<BannerModel> banners;
  const BannersSliderWidget({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getMediaQueryHeight(context, 0.22),
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getMediaQueryWidth(context, 0.03)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: banners[index].image,
              fit: BoxFit.fill,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.asset(
                ImagesPaths.loadingImageError,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
