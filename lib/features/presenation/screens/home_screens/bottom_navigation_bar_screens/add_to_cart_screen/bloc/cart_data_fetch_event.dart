part of 'cart_data_fetch_bloc.dart';

sealed class CartDataFetchEvent extends Equatable {
  const CartDataFetchEvent();

  @override
  List<Object> get props => [];
}

final class CartDataFetchStarted extends CartDataFetchEvent {}
