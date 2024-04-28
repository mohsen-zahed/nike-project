import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/constants/products_sort_cons.dart';
import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository iBannersRepository;
  final IProductsRepository iProductsRepository;
  HomeBloc(
      {required this.iBannersRepository, required this.iProductsRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
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
        } catch (e) {
          emit(
            HomeFailed(errorMessage: e.toString()),
          );
        }
      }
    });
  }
}
