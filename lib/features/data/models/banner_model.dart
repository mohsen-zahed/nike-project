class BannerModel {
  final int id;
  final String image;
  final int linkType;
  final String linkValue;

  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        linkType = json['link_type'],
        linkValue = json['link_value'];
}
