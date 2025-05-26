import 'package:dsfulfill_admin_app/models/line_items_model.dart';
import 'package:dsfulfill_admin_app/models/shipping_address_model.dart';
import 'package:dsfulfill_admin_app/models/shop_model.dart';

class OrderModel {
  late int id;
  late String platform;
  late String shopName;
  late int status;
  late String createdAt;
  late String name;
  late String orderId;
  late String country;
  late String currency;
  late String statusName;
  late int isShipping;
  late int financialStatus;
  late int abnormalStatus;
  late String customerName;
  late String countryCode;
  late String stockStatus;
  late int customerId;
  List<LineItemsModel>? lineItems;
  Map<String, dynamic>? quotePrice;
  List<AbnormalModel>? abnormal;
  ShippingAddressModel? shippingAddress;
  ShopModel? shop;
  List<LogsModel>? logs;
  List<Map<String, dynamic>>? packages;

  OrderModel({
    required this.id,
    required this.platform,
    required this.shopName,
    required this.status,
    required this.createdAt,
    required this.name,
    required this.orderId,
    required this.country,
    required this.currency,
    required this.statusName,
    required this.isShipping,
    required this.financialStatus,
    required this.abnormalStatus,
    this.lineItems,
    this.quotePrice,
    this.abnormal,
    this.shippingAddress,
    this.shop,
    this.logs,
    required this.customerName,
    required this.countryCode,
    required this.stockStatus,
    required this.customerId,
    this.packages,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['platform'] != null) {
      platform = json['platform'];
    }
    if (json['shop_name'] != null) {
      shopName = json['shop_name'];
    }
    if (json['status'] != null) {
      status = json['status'];
    }
    createdAt = json['created_at'];
    name = json['name'];
    orderId = json['order_id'];
    if (json['country'] != null) {
      country = json['country'];
    }
    currency = json['currency'];
    if (json['line_items'] != null) {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItemsModel.fromJson(v));
      });
    }
    if (json['stock_status'] != null) {
      stockStatus = json['stock_status'];
    }
    if (json['customer_name'] != null) {
      customerName = json['customer_name'];
    }
    if (json['quote_price'] != null) {
      quotePrice = json['quote_price'];
    }
    if (json['packages'] != null) {
      packages = (json['packages'] as List).cast<Map<String, dynamic>>();
    }
    if (json['is_shipping'] != null) {
      isShipping = json['is_shipping'];
    }
    if (json['financial_status'] != null) {
      financialStatus = json['financial_status'];
    }
    if (json['abnormal'] != null) {
      abnormal = [];
      json['abnormal'].forEach((v) {
        abnormal!.add(AbnormalModel.fromJson(v));
      });
    }
    if (json['status_name'] != null) {
      statusName = json['status_name'];
    }
    if (json['shippingAddress'] != null) {
      shippingAddress = ShippingAddressModel.fromJson(json['shippingAddress']);
    }
    if (json['shop'] != null) {
      shop = ShopModel.fromJson(json['shop']);
    }
    if (json['logs'] != null) {
      logs = [];
      json['logs'].forEach((v) {
        logs!.add(LogsModel.fromJson(v));
      });
    }
    if (json['abnormal_status'] != null) {
      abnormalStatus = json['abnormal_status'];
    } else {
      abnormalStatus = 0;
    }
    if (json['country_code'] != null) {
      countryCode = json['country_code'];
    }
    if (json['customer_id'] != null) {
      customerId = json['customer_id'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform,
      'shop_name': shopName,
      'status': status,
      'created_at': createdAt,
      'name': name,
      'order_id': orderId,
      'country': country,
      'currency': currency,
      'line_items': lineItems?.map((v) => v.toJson()).toList(),
      'quote_price': quotePrice,
      'status_name': statusName,
      'abnormal': abnormal?.map((v) => v.toJson()).toList(),
      'is_shipping': isShipping,
      'financial_status': financialStatus,
      'shippingAddress': shippingAddress?.toJson(),
      'shop': shop?.toJson(),
      'logs': logs?.map((v) => v.toJson()).toList(),
      'abnormal_status': abnormalStatus,
      'customer_name': customerName,
      'country_code': countryCode,
      'stock_status': stockStatus,
      'customer_id': customerId,
      'packages': packages,
    };
  }
}

class AbnormalModel {
  late int id;
  late String description;
  late String abnormalTime;

  AbnormalModel({
    required this.id,
    required this.description,
    required this.abnormalTime,
  });

  AbnormalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    abnormalTime = json['abnormal_time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'abnormal_time': abnormalTime,
    };
  }
}

class LogsModel {
  late int id;
  late String content;
  late String createdAt;

  LogsModel({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  LogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt,
    };
  }
}
