class CartResponseModel {
  final int productId;
  final int cartItemId;
  final int count;

  CartResponseModel.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartItemId = json['id'],
        count = json['count'];
}
