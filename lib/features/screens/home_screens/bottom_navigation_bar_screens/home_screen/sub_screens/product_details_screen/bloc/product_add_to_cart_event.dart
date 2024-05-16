part of 'product_add_to_cart_bloc.dart';

sealed class ProductAddToCartEvent extends Equatable {
  const ProductAddToCartEvent();

  @override
  List<Object> get props => [];
}

final class CartAddToCartButtonIsClicked extends ProductAddToCartEvent {
  final int productId;

  const CartAddToCartButtonIsClicked({required this.productId});
}
