import 'package:easy_localization/easy_localization.dart';
import 'package:nike_project/core/exception/app_exception.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:nike_project/translations/locale_keys.g.dart';

abstract class IProductsRepositoryRemoteSource {
  Future<List<ProductModel>> getAllProducts(int sort);
  Future<List<ProductModel>> searchProducts(String searchTerm);
}

class IProductsRepositoryRemoteSourceImp
    implements IProductsRepositoryRemoteSource {
  final Dio httpClient;

  IProductsRepositoryRemoteSourceImp({required this.httpClient});
  @override
  Future<List<ProductModel>> getAllProducts(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');
    if (response.statusCode != 200) {
      throw AppException(
        errorException: LocaleKeys.something_went_wrong.tr(),
      );
    }

    final products = <ProductModel>[];
    (response.data as List).forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductModel>> searchProducts(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    if (response.statusCode != 200) {
      throw AppException(
        errorException: LocaleKeys.something_went_wrong.tr(),
      );
    }
    final products = <ProductModel>[];
    (response.data as List).forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
    return products;
  }
}
