class ShopModel {
  late int id;
  late String shopName;
  late String platform;

  ShopModel({
    required this.id,
    required this.shopName,
    required this.platform,
  });

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'shop_name': shopName, 'platform': platform};
  }
}
