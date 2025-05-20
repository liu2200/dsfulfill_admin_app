import 'package:dsfulfill_cient_app/models/order_statistics.dart';

class HomeModel {
  int? expressLinesCount;
  int? goodsCount;
  int? orderCount;
  int? rechargeCount;

  OrderStatistics? orderStatistics;

  HomeModel({
    required this.orderStatistics,
    required this.expressLinesCount,
    required this.goodsCount,
    required this.orderCount,
    required this.rechargeCount,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      orderStatistics: OrderStatistics.fromJson(json['order_statistics']),
      expressLinesCount: json['express_lines_count'] ?? 0,
      goodsCount: json['goods_count'] ?? 0,
      orderCount: json['order_count'] ?? 0,
      rechargeCount: json['recharge_count'] ?? 0,
    );
  }
}
