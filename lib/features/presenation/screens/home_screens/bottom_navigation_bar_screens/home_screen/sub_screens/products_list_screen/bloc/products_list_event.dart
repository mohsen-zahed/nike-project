part of 'products_list_bloc.dart';

sealed class ProductsListEvent extends Equatable {
  const ProductsListEvent();

  @override
  List<Object> get props => [];
}

final class ProductsListStarted extends ProductsListEvent {
  final int sort;

  const ProductsListStarted({
    required this.sort,
  });

  @override
  List<Object> get props => [sort];
}
