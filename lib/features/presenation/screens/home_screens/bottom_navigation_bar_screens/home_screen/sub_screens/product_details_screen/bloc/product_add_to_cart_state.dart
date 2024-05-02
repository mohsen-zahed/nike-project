part of 'product_add_to_cart_bloc.dart';

sealed class ProductAddToCartState extends Equatable {
  const ProductAddToCartState();

  @override
  List<Object> get props => [];
}

final class ProductAddToCartInitial extends ProductAddToCartState {}

final class ProductAddToCartLoading extends ProductAddToCartState {}

final class ProductAddToCartFailed extends ProductAddToCartState {
  final String errorMessage;

  const ProductAddToCartFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class ProductAddToCartSuccess extends ProductAddToCartState {}
