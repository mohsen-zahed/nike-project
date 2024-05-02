class AddToCartResponseModel {
  final int productId;
  final int cartItemId;
  final int count;

  AddToCartResponseModel.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartItemId = json['id'],
        count = json['count'];
}
