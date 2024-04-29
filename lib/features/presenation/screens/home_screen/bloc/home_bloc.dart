import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/products_sort_cons.dart';
import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository iBannersRepository;
  final IProductsRepository iProductsRepository;
  HomeBloc(
      {required this.iBannersRepository, required this.iProductsRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        emit(HomeLoading());
        try {
          final banners = await iBannersRepository.getAllBanners();
          final latestProducts =
              await iProductsRepository.getAllProducts(ProductsSortCons.latest);
          final popularProducts = await iProductsRepository
              .getAllProducts(ProductsSortCons.popular);
          emit(
            HomeSuccess(
              banners: banners,
              popularProducts: popularProducts,
              latestProducts: latestProducts,
            ),
          );
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(
              HomeFailed(errorMessage: LocaleKeys.dio_error_bad_response.tr()),
            );
          } else if (e.type == DioExceptionType.connectionError) {
            emit(HomeFailed(
              errorMessage: LocaleKeys.dio_error_connection_error.tr(),
            ));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(HomeFailed(
              errorMessage: LocaleKeys.dio_error_connection_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(HomeFailed(
              errorMessage: LocaleKeys.dio_error_sent_timeout.tr(),
            ));
          } else if (e.type == DioExceptionType.unknown) {
            emit(HomeFailed(
              errorMessage: LocaleKeys.something_went_wrong.tr(),
            ));
          } else {
            emit(HomeFailed(
              errorMessage: LocaleKeys.try_again.tr(),
            ));
          }
        }
      }
    });
  }
}
