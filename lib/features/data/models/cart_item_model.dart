import 'package:nike_project/features/data/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int id;
  final int count;

  CartItemModel.fromJson(Map<String, dynamic> json)
      : product = ProductModel.fromJson(json),
        id = json['id'],
        count = json['cart_item_id'];
}
