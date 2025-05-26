import 'package:dsfulfill_admin_app/models/skus_model.dart';

class ProductModel {
  late int id;
  late String spu;
  late String goodsName;
  late int categoryId;
  late String categoryName;
  late String brand;
  late String unit;
  late String purchasePrice;
  late String purchaseUrl;
  late String coverImage;
  late String goodsLowestPrice;
  late int saleCount;
  late int status;
  late String statusName;
  late GoodsAudit goodsAudit;
  late int isHot;
  late int skusCount;
  late Developer developer;
  late String maxPurchasePrice;
  late String minPurchasePrice;
  late String maxSalePrice;
  late String minSalePrice;
  late String createdAt;
  late int goodsType;
  late String goodsTypeName;
  late int packingMaterialsType;
  late String packingMaterialsTypeName;
  late List<Option> options;
  late String purchasePlatform;
  late List<dynamic> tags;
  late List<dynamic> mainImages;
  late List<SkusModel> skus;
  late String alias;
  late String detail;

  ProductModel({
    required this.id,
    required this.spu,
    required this.goodsName,
    required this.categoryId,
    required this.categoryName,
    required this.brand,
    required this.unit,
    required this.purchasePrice,
    required this.purchaseUrl,
    required this.coverImage,
    required this.goodsLowestPrice,
    required this.saleCount,
    required this.status,
    required this.statusName,
    required this.goodsAudit,
    required this.isHot,
    required this.skusCount,
    required this.developer,
    required this.maxPurchasePrice,
    required this.minPurchasePrice,
    required this.maxSalePrice,
    required this.minSalePrice,
    required this.createdAt,
    required this.goodsType,
    required this.goodsTypeName,
    required this.packingMaterialsType,
    required this.packingMaterialsTypeName,
    required this.options,
    required this.purchasePlatform,
    required this.tags,
    required this.mainImages,
    required this.skus,
    required this.alias,
    required this.detail,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    spu = json['spu'];
    goodsName = json['goods_name'];
    categoryId = _parseInt(json['category_id']);
    categoryName = json['category_name'];
    brand = json['brand'] ?? '';
    unit = json['unit'] ?? '';
    purchasePrice = json['purchase_price'];
    purchaseUrl = json['purchase_url'];
    coverImage = json['cover_image'];
    goodsLowestPrice = json['goods_lowest_price'];
    saleCount = _parseInt(json['sale_count']);
    status = _parseInt(json['status']);
    statusName = json['status_name'];
    if (json['main_images'] != null) {
      mainImages = json['main_images'];
    }
    if (json['detail'] != null) {
      detail = json['detail'];
    }
    if (json['alias'] != null) {
      alias = json['alias'];
    }
    if (json['skus'] != null) {
      skus = (json['skus'] as List<dynamic>?)
              ?.map((e) => SkusModel.fromJson(e))
              .toList() ??
          [];
    }
    if (json['goods_audit'] != null) {
      goodsAudit = GoodsAudit.fromJson(json['goods_audit']);
    }
    isHot = _parseInt(json['is_hot']);
    skusCount = _parseInt(json['skus_count']);
    if (json['developer'] != null) {
      developer = Developer.fromJson(json['developer']);
    }
    if (json['max_purchase_price'] != null) {
      maxPurchasePrice = json['max_purchase_price'];
    }
    if (json['min_purchase_price'] != null) {
      minPurchasePrice = json['min_purchase_price'];
    }
    if (json['max_sale_price'] != null) {
      maxSalePrice = json['max_sale_price'];
    }
    if (json['min_sale_price'] != null) {
      minSalePrice = json['min_sale_price'];
    }
    createdAt = json['created_at'];
    if (json['goods_type'] != null) {
      goodsType = _parseInt(json['goods_type']);
    }
    if (json['goods_type_name'] != null) {
      goodsTypeName = json['goods_type_name'];
    }
    if (json['packing_materials_type'] != null) {
      packingMaterialsType = _parseInt(json['packing_materials_type']);
    }
    if (json['packing_materials_type_name'] != null) {
      packingMaterialsTypeName = json['packing_materials_type_name'];
    }
    if (json['options'] != null) {
      options = (json['options'] as List<dynamic>?)
              ?.map((e) => Option.fromJson(e))
              .toList() ??
          [];
    }
    if (json['purchase_platform'] != null) {
      purchasePlatform = json['purchase_platform'];
    }
    if (json['tags'] != null) {
      tags = json['tags'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'spu': spu,
      'goods_name': goodsName,
      'category_id': categoryId,
      'category_name': categoryName,
      'brand': brand,
      'unit': unit,
      'purchase_price': purchasePrice,
      'purchase_url': purchaseUrl,
      'cover_image': coverImage,
      'goods_lowest_price': goodsLowestPrice,
      'sale_count': saleCount,
      'status': status,
      'status_name': statusName,
      'goods_audit': goodsAudit.toJson(),
      'is_hot': isHot,
      'skus_count': skusCount,
      'developer': developer.toJson(),
      'max_purchase_price': maxPurchasePrice,
      'min_purchase_price': minPurchasePrice,
      'max_sale_price': maxSalePrice,
      'min_sale_price': minSalePrice,
      'created_at': createdAt,
      'goods_type': goodsType,
      'goods_type_name': goodsTypeName,
      'packing_materials_type': packingMaterialsType,
      'packing_materials_type_name': packingMaterialsTypeName,
      'options': options.map((e) => e.toJson()).toList(),
      'purchase_platform': purchasePlatform,
      'tags': tags,
      'skus': skus.map((e) => e.toJson()).toList(),
      'alias': alias,
      'detail': detail,
    };
  }
}

class GoodsAudit {
  late int auditStatus;
  late String auditStatusName;
  late String auditUserName;
  late String auditTime;
  late String auditRemark;
  late int commitStatus;
  late String commitStatusName;
  late String commitUserName;
  late String commitTime;

  GoodsAudit({
    required this.auditStatus,
    required this.auditStatusName,
    required this.auditUserName,
    required this.auditTime,
    required this.auditRemark,
    required this.commitStatus,
    required this.commitStatusName,
    required this.commitUserName,
    required this.commitTime,
  });

  GoodsAudit.fromJson(Map<String, dynamic> json) {
    var auditStatusRaw = json['audit_status'];
    if (auditStatusRaw is String) {
      auditStatus = int.tryParse(auditStatusRaw) ?? 0;
    } else {
      auditStatus = 0;
    }
    if (json['audit_status_name'] != null) {
      auditStatusName = json['audit_status_name'];
    }
    if (json['audit_user_name'] != null) {
      auditUserName = json['audit_user_name'];
    }
    if (json['audit_time'] != null) {
      auditTime = json['audit_time'];
    }
    auditRemark = json['audit_remark'] ?? '';
    var commitStatusRaw = json['commit_status'];
    if (commitStatusRaw is String) {
      commitStatus = int.tryParse(commitStatusRaw) ?? 0;
    } else {
      commitStatus = 0;
    }
    commitStatusName = json['commit_status_name'];
    commitUserName = json['commit_user_name'] ?? '';
    commitTime = json['commit_time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'audit_status': auditStatus,
      'audit_status_name': auditStatusName,
      'audit_user_name': auditUserName,
      'audit_time': auditTime,
      'audit_remark': auditRemark,
      'commit_status': commitStatus,
      'commit_status_name': commitStatusName,
      'commit_user_name': commitUserName,
      'commit_time': commitTime,
    };
  }
}

class Developer {
  late int id;
  late String name;

  Developer({
    required this.id,
    required this.name,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: _parseInt(json['id']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Option {
  late String name;
  late List<Spec> specs;

  Option({
    required this.name,
    required this.specs,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      name: json['name'],
      specs: (json['specs'] as List<dynamic>?)
              ?.map((e) => Spec.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specs': specs.map((e) => e.toJson()).toList(),
    };
  }
}

class Spec {
  late String name;
  late List<String> image;
  Spec({
    required this.name,
    required this.image,
  });

  factory Spec.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    if (json['image'] is String) {
      if ((json['image'] as String).isNotEmpty) {
        images = [json['image']];
      }
    } else if (json['image'] is List) {
      images = (json['image'] as List).map((e) => e.toString()).toList();
    }
    return Spec(
      name: json['name']?.toString() ?? '',
      image: images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}

int _parseInt(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
