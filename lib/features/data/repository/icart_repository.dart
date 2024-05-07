import 'package:flutter/material.dart';
import 'package:nike_project/features/data/models/add_to_cart_response_model.dart';
import 'package:nike_project/features/data/models/cart_response_model.dart';
import 'package:nike_project/features/data/source/icart_data_source.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

final cartRepository = CartRepositoryImp(
    iCartDataSource: CartDataSourceImp(httpClient: httpClient));

abstract class ICartRepository {
  Future<AddToCartResponseModel> add(int productId);
  Future<void> delete(int cartItemId);
  Future<AddToCartResponseModel> changeCount(int cartItemId, int count);
  Future<int> count();
  Future<CartResponseModel> getAll();
}

class CartRepositoryImp extends ICartRepository {
  final ICartDataSource iCartDataSource;
  ValueNotifier<int> cartItemCountNotifier = ValueNotifier(0);

  CartRepositoryImp({required this.iCartDataSource});
  @override
  Future<AddToCartResponseModel> add(int productId) =>
      iCartDataSource.add(productId);

  @override
  Future<AddToCartResponseModel> changeCount(int cartItemId, int count) =>
      iCartDataSource.changeCount(cartItemId, count);

  @override
  Future<int> count() async {
    final count = await iCartDataSource.count();
    cartItemCountNotifier.value = count;
    return count;
  }

  @override
  Future<void> delete(int cartItemId) => iCartDataSource.delete(cartItemId);

  @override
  Future<CartResponseModel> getAll() => iCartDataSource.getAll();
}
