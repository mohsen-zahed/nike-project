import 'package:dio/dio.dart';
import 'package:nike_project/features/data/models/add_to_cart_response_model.dart';
import 'package:nike_project/features/data/models/cart_response_model.dart';

abstract class ICartDataSource {
  Future<AddToCartResponseModel> add(int productId);
  Future<void> delete(int cartItemId);
  Future<AddToCartResponseModel> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<CartResponseModel> getAll();
}

class CartDataSourceImp extends ICartDataSource {
  final Dio httpClient;

  CartDataSourceImp({required this.httpClient});
  @override
  Future<AddToCartResponseModel> add(int productId) async {
    final response = await httpClient.post('cart/add', data: {
      "product_id": productId,
    });
    return AddToCartResponseModel.fromJson(response.data);
  }

  @override
  Future<AddToCartResponseModel> changeCount(int cartItemId, int count) {
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
  Future<CartResponseModel> getAll() async {
    final response = await httpClient.get('cart/list');
    return CartResponseModel.fromJson(response.data);
  }
}
