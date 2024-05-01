import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/data/source/iproducts_data_remote_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final productRepository = ProductsRepositoryImp(
  iProductsRepositoryRemoteSource:
      ProductsDataRemoteSourceImp(httpClient: httpClient),
);

//* -----_----- *\\

abstract class IProductsRepository {
  Future<List<ProductModel>> getAllProducts(int sort);
  Future<List<ProductModel>> searchProducts(String searchTerm);
}

class ProductsRepositoryImp implements IProductsRepository {
  final IProductsDataRemoteSource iProductsRepositoryRemoteSource;

  ProductsRepositoryImp({required this.iProductsRepositoryRemoteSource});
  @override
  Future<List<ProductModel>> getAllProducts(int sort) async =>
      await iProductsRepositoryRemoteSource.getAllProducts(sort);

  @override
  Future<List<ProductModel>> searchProducts(String searchTerm) async =>
      await iProductsRepositoryRemoteSource.searchProducts(searchTerm);
}
