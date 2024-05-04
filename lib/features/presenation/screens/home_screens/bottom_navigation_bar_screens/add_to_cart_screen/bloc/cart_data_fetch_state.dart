part of 'cart_data_fetch_bloc.dart';

sealed class CartDataFetchState extends Equatable {
  const CartDataFetchState();

  @override
  List<Object> get props => [];
}

final class CartDataFetchLoading extends CartDataFetchState {}

final class CartDataFetchFailed extends CartDataFetchState {
  final String errorMessage;

  const CartDataFetchFailed({required this.errorMessage});
}

final class CartDataFetchSuccess extends CartDataFetchState {
  final CartResponseModel cartResponseItems;
  @override
  const CartDataFetchSuccess({required this.cartResponseItems});
  List<Object> get props => [cartResponseItems];
}
