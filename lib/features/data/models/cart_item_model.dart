import 'package:nike_project/features/data/models/product_model.dart';

//* This is the Model for existed items in Cart...
//* When we send a request to fetch items in cart this model will be used to fetch the response,
//* which contains three values.

//! Virtualization :)
//?  "cart_items : [
//!   {
//!     'cart_item_id': 4383,
//!     'product': {
//!      "id": 4,
//!       "title": "title body",
//!        "price": 390293203,
//!         "discount": 203920,
//!         .
//!         .
//!         .
//!      },
//!      'count': 1,
//!   },
//!   {
//!     'cart_item_id': 6483,
//!     'product': {
//!      "id": 5,
//!       "title": "title body",
//!        "price": 34324303,
//!         "discount": 43920,
//!         .
//!         .
//!         .
//!      },
//!      'count': 2,
//!   }
//? ]"

class CartItemModel {
  final ProductModel product;
  final int cartItemId;
  final int count;

  CartItemModel.fromJson(Map<String, dynamic> json)
      : cartItemId = json['cart_item_id'],
        product = ProductModel.fromJson(json['product']),
        count = json['count'];

  static List<CartItemModel> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemModel> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartItemModel.fromJson(element));
    });
    return cartItems;
  }
}
