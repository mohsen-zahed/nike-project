part of 'products_list_bloc.dart';

sealed class ProductsListState extends Equatable {
  const ProductsListState();

  @override
  List<Object> get props => [];
}

final class ProductsListLoading extends ProductsListState {}

final class ProductsListSuccess extends ProductsListState {
  final List<ProductModel> products;
  final int sort;
  final List<String> sortNames;

  const ProductsListSuccess({
    required this.sort,
    required this.sortNames,
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

final class ProductsListFailed extends ProductsListState {
  final String errorMessage;

  const ProductsListFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
