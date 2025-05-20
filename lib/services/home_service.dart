import 'package:dsfulfill_cient_app/common/http_client.dart';
import 'package:dsfulfill_cient_app/models/home_model.dart';
import 'package:dsfulfill_cient_app/models/order_statistics.dart';
import 'package:dsfulfill_cient_app/models/order_statistics_model.dart';

class HomeService {
  static const String getHomeDataApi = 'home';
  static const String getOrderTotalStatisticsApi =
      'home/delivery-order-statistics';
  static const String getOrderRevenueStatisticsApi =
      'home/order-revenue-statistics';
  // 获取消息
  static const String readNoticeApi = 'ctu-user-message/read';
  //统计数据
  static const String orderCountApi = 'order/count/status';

  static const String getCustomerRechargeStatisticsApi =
      'home/customer-recharge-statistics';

  static Future<List<OrderStatisticsModel>> getCustomerRechargeStatistics(
      Map<String, dynamic> params) async {
    List<OrderStatisticsModel> result = [];
    await ApiConfig.instance
        .get(getCustomerRechargeStatisticsApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(OrderStatisticsModel.fromJson(data));
        });
      } else {
        // throw Exception(response.error!.message);
      }
    });
    return result;
  }

  static Future<List<OrderStatisticsModel>> getOrderRevenueStatistics(
      Map<String, dynamic> params) async {
    List<OrderStatisticsModel> result = [];
    await ApiConfig.instance
        .get(getOrderRevenueStatisticsApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(OrderStatisticsModel.fromJson(data));
        });
      }
    });
    return result;
  }

  static Future<List<OrderStatisticsModel>> getOrderTotalStatistics(
      Map<String, dynamic> params) async {
    List<OrderStatisticsModel> result = [];
    await ApiConfig.instance
        .get(getOrderTotalStatisticsApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(OrderStatisticsModel.fromJson(data));
        });
      }
    });
    return result;
  }

  static Future<Map<String, dynamic>> getOrderCount(
      Map<String, dynamic> params) async {
    Map<String, dynamic> result = {};
    await ApiConfig.instance.get(orderCountApi, data: params).then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  static Future<bool> readNotice(String id) async {
    bool result = false;
    await ApiConfig.instance.put(readNoticeApi, data: {
      'ids': [id]
    }).then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<HomeModel> getHomeData() async {
    HomeModel result = HomeModel(
      orderStatistics: null,
      expressLinesCount: 0,
      goodsCount: 0,
      orderCount: 0,
      rechargeCount: 0,
    );
    await ApiConfig.instance.get(getHomeDataApi).then((response) {
      if (response.ok) {
        var list = response.data;
        result = HomeModel(
          expressLinesCount: list['express_lines_count'],
          goodsCount: list['goods_count'],
          orderCount: list['order_count'],
          rechargeCount: list['recharge_count'],
          orderStatistics: OrderStatistics.fromJson(list['order_statistics']),
        );
      } else {
        // throw Exception(response.error!.message);
      }
    });
    return result;
  }
}
