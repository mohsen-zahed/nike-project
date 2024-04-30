part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeSuccess extends HomeState {
  final List<BannerModel> banners;
  final List<ProductModel> popularProducts;
  final List<ProductModel> latestProducts;

  const HomeSuccess(
      {required this.banners,
      required this.popularProducts,
      required this.latestProducts});
}

final class HomeFailed extends HomeState {
  final String errorMessage;

  const HomeFailed({required this.errorMessage});
}

final class HomeLoading extends HomeState {}
