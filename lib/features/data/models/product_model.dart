class ProductModel {
  final int id;
  final String title;
  final String image;
  final int price;
  final int discount;
  final int previousPrice;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = json['image'],
        price = json['price'],
        discount = json['discount'],
        previousPrice = json['previous_price'] ?? json['price'];
}
