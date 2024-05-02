import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/cart_item_model.dart';
import 'package:nike_project/features/data/models/cart_response_model.dart';

abstract class ICartDataSource {
  Future<CartResponseModel> add(int productId);
  Future<void> delete(int cartItemId);
  Future<CartResponseModel> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<List<CartItemModel>> getAll();
}

class CartDataSourceImp extends ICartDataSource {
  final Dio httpClient;

  CartDataSourceImp({required this.httpClient});
  @override
  Future<CartResponseModel> add(int productId) async {
    final response = await httpClient.post('cart/add', data: {
      "product_id": productId,
    });
    return CartResponseModel.fromJson(response.data);
  }

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
