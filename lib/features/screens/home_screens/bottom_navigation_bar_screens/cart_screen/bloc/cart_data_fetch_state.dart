part of 'cart_data_fetch_bloc.dart';

sealed class CartDataFetchState {
  const CartDataFetchState();
}

final class CartDataFetchLoading extends CartDataFetchState {}

final class CartDataFetchFailed extends CartDataFetchState {
  final String errorMessage;

  const CartDataFetchFailed({required this.errorMessage});
}

final class CartDataFetchSuccess extends CartDataFetchState {
  final CartResponseModel cartResponseItems;

  const CartDataFetchSuccess({required this.cartResponseItems});
}

final class CartAuthRequested extends CartDataFetchState {}

final class CartEmptyData extends CartDataFetchState {}
