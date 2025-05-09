class QuotePriceModel {
  late String goodsPrice;
  late String logisticsFee;
  late String favourablePrice;
  late String createdAt;
  late String otherSupplementPrice;
  late String totalPrice;

  QuotePriceModel({
    required this.goodsPrice,
    required this.logisticsFee,
    required this.favourablePrice,
    required this.createdAt,
    required this.otherSupplementPrice,
    required this.totalPrice,
  });

  QuotePriceModel.fromJson(Map<String, dynamic> json) {
    goodsPrice = json['goods_price'];
    logisticsFee = json['logistics_fee'];
    favourablePrice = json['favourable_price'];
    createdAt = json['created_at'];
    otherSupplementPrice = json['other_supplement_price'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'goods_price': goodsPrice,
      'logistics_fee': logisticsFee,
      'favourable_price': favourablePrice,
      'created_at': createdAt,
      'other_supplement_price': otherSupplementPrice,
      'total_price': totalPrice,
    };
  }
}
