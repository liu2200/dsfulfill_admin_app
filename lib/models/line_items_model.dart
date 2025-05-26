import 'package:dsfulfill_admin_app/models/skus_model.dart';

class LineItemsModel {
  late String createdAt;
  late int id;
  late int isDelete;
  late String logisticsFee;
  late String name;
  late String price;
  late String profit;
  late String purchasePrice;
  late int quantity;
  late String sku;
  late String title;
  late String updatedAt;
  late String variantTitle;
  String goodsSkuId = '';
  late String productUrl = '';
  String? img;
  List<dynamic>? imgs;
  MappingModel? mapping;
  Map<String, dynamic>? declaration;
  String? variantId;
  LineItemsModel({
    required this.createdAt,
    required this.id,
    required this.isDelete,
    required this.logisticsFee,
    required this.name,
    required this.price,
    required this.profit,
    required this.purchasePrice,
    required this.quantity,
    required this.sku,
    required this.title,
    required this.updatedAt,
    required this.variantTitle,
    this.img,
    this.imgs,
    this.mapping,
    this.declaration,
    this.variantId,
    required this.goodsSkuId,
    required this.productUrl,
  });

  LineItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['created_at'] != null) {
      createdAt = json['created_at'];
    }
    id = json['id'];
    if (json['logistics_fee'] != null) {
      logisticsFee = json['logistics_fee'];
    }
    name = json['name'];
    price = json['price'];
    profit = json['profit'];
    purchasePrice = json['purchase_price'];
    quantity = json['quantity'];
    if (json['sku'] != null) {
      sku = json['sku'];
    }
    title = json['title'];
    if (json['updated_at'] != null) {
      updatedAt = json['updated_at'];
    }
    if (json['product_url'] != null) {
      productUrl = json['product_url'];
    }
    variantTitle = '';
    if (json['variant_title'] != null) {
      variantTitle = json['variant_title'];
    }
    if (json['imgs'] != null) {
      if (json['imgs'].isNotEmpty) {
        img = json['imgs'].first;
        imgs = json['imgs'];
      }
    }
    if (json['mapping'] != null) {
      mapping = MappingModel.fromJson(json['mapping']);
    }
    if (json['goods_sku_id'] != null) {
      goodsSkuId = json['goods_sku_id'].toString();
    }
    if (json['declaration'] != null) {
      declaration = json['declaration'];
    }
    if (json['variant_id'] != null) {
      variantId = json['variant_id'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'id': id,
      'is_delete': isDelete,
      'logistics_fee': logisticsFee,
      'name': name,
      'price': price,
      'profit': profit,
      'purchase_price': purchasePrice,
      'quantity': quantity,
      'sku': sku,
      'title': title,
      'updated_at': updatedAt,
      'variant_title': variantTitle,
      'img': img,
      'imgs': imgs,
      'mapping': mapping?.toJson(),
      'declaration': declaration,
      'variant_id': variantId,
      'goods_sku_id': goodsSkuId,
      'product_url': productUrl,
    };
  }
}

class MappingModel {
  late int id;
  SkusModel? goodsSku;
  MappingModel({required this.id, this.goodsSku});

  MappingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['goods_sku'] != null) {
      goodsSku = SkusModel.fromJson(json['goods_sku']);
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'goods_sku': goodsSku};
  }
}
