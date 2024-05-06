import 'package:nike_project/features/data/models/cart_item_model.dart';

class CartResponseModel {
  final List<CartItemModel> cartItems;
  int payablePrice;
  int totalPrice;
  int shippingCost;

  CartResponseModel.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemModel.parseJsonArray(json['cart_items']),
        payablePrice = json["payable_price"],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
