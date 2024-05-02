import 'package:nike_project/features/data/models/cart_item_model.dart';
import 'package:nike_project/features/data/models/cart_response_model.dart';
import 'package:nike_project/features/data/source/icart_data_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final cartRepository = CartRepositoryImp(
    iCartDataSource: CartDataSourceImp(httpClient: httpClient));

abstract class ICartRepository {
  Future<CartResponseModel> add(int productId);
  Future<void> delete(int cartItemId);
  Future<CartResponseModel> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<List<CartItemModel>> getAll();
}

class CartRepositoryImp extends ICartRepository {
  final ICartDataSource iCartDataSource;

  CartRepositoryImp({required this.iCartDataSource});
  @override
  Future<CartResponseModel> add(int productId) =>
      iCartDataSource.add(productId);

  @override
  Future<CartResponseModel> changeCount(int cartItemId, int count) {
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemModel>> getAll() {
    throw UnimplementedError();
  }
}
