import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/data/source/iproducts_repository_remote_source.dart';

//* just for test

final httpClient = Dio(BaseOptions(
  baseUrl: 'http://expertdevelopers.ir/api/v1/',
));

final productRepository = IProductsRepositoryImp(
  iProductsRepositoryRemoteSource:
      IProductsRepositoryRemoteSourceImp(httpClient: httpClient),
);

//* -----_----- *\\

abstract class IProductsRepository {
  Future<List<ProductModel>> getAllProducts(int sort);
  Future<List<ProductModel>> searchProducts(String searchTerm);
}

class IProductsRepositoryImp implements IProductsRepository {
  final IProductsRepositoryRemoteSource iProductsRepositoryRemoteSource;

  IProductsRepositoryImp({required this.iProductsRepositoryRemoteSource});
  @override
  Future<List<ProductModel>> getAllProducts(int sort) async =>
      await iProductsRepositoryRemoteSource.getAllProducts(sort);

  @override
  Future<List<ProductModel>> searchProducts(String searchTerm) async =>
      await iProductsRepositoryRemoteSource.searchProducts(searchTerm);
}
