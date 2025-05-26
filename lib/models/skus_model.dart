class SkusModel {
  late int id;
  late String skuId;
  late String price;
  late int quantity;
  late List<dynamic> images;
  late String purchasePrice;
  late String quotePrice;
  late String salePrice;
  late String specName;
  late String profit;
  late double weight;
  Map<String, dynamic>? goods;
  SkusModel({
    required this.id,
    required this.skuId,
    required this.price,
    required this.quantity,
    required this.images,
    required this.purchasePrice,
    required this.quotePrice,
    required this.salePrice,
    required this.specName,
    required this.profit,
    this.goods,
    required this.weight,
  });

  SkusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuId = json['sku_id'];
    quantity = json['quantity'];
    ;
    images = json['images'];
    purchasePrice = json['purchase_price'];
    quotePrice = json['quote_price'];
    salePrice = json['sale_price'];
    specName = json['spec_name'];
    if (json['price'] != null) {
      price = json['price'];
    } else {
      price = '0';
    }
    if (json['profit'] != null) {
      profit = json['profit'];
    } else {
      profit = '0';
    }
    if (json['goods'] != null) {
      goods = json['goods'];
    }
    var weightRaw = json['weight'];
    if (weightRaw is int) {
      weight = weightRaw.toDouble();
    } else if (weightRaw is double) {
      weight = weightRaw;
    } else if (weightRaw is String) {
      weight = double.tryParse(weightRaw) ?? 0;
    } else {
      weight = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku_id'] = skuId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['images'] = images;
    data['purchase_price'] = purchasePrice;
    data['quote_price'] = quotePrice;
    data['sale_price'] = salePrice;
    data['spec_name'] = specName;
    data['profit'] = profit;
    data['goods'] = goods;
    data['weight'] = weight;
    return data;
  }
}
