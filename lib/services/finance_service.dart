import 'package:dsfulfill_cient_app/common/http_client.dart';
import 'package:dsfulfill_cient_app/models/balance_record_model.dart';
import 'package:dsfulfill_cient_app/models/online_recharge_model.dart';
import 'package:dsfulfill_cient_app/models/recharge_model.dart';

class FinanceService {
  static const String rechargeApi = 'recharge-apply';
  static const String rechargeAuditApi = 'recharge-apply/audit';
  static const String onlineRechargeApi = 'recharge-apply/online-recharge';
  static const String balanceRecordApi = 'balance-record';

  static Future<BalanceRecordModel?> getBalanceRecordDetail(id) async {
    BalanceRecordModel? result;
    await ApiConfig.instance.get('$balanceRecordApi/$id').then((response) {
      if (response.ok) {
        result = BalanceRecordModel.fromJson(response.data);
      }
    });
    return result;
  }

  static Future<Map> getBalanceRecordList(
      [Map<String, dynamic>? params]) async {
    var page = (params is Map) ? params!['page'] : 1;
    Map result = {"dataList": null, 'total': 1, 'pageIndex': page};
    List<BalanceRecordModel> orderList = <BalanceRecordModel>[];
    await ApiConfig.instance
        .get(balanceRecordApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          orderList.add(BalanceRecordModel.fromJson(data));
        });
      }
      result = {
        "dataList": orderList,
        'total': response.meta?['last_page'],
        'pageIndex': response.meta?['current_page']
      };
    });
    return result;
  }

  static Future<Map> getOnlineRechargeList(
      [Map<String, dynamic>? params]) async {
    var page = (params is Map) ? params!['page'] : 1;
    Map result = {"dataList": null, 'total': 1, 'pageIndex': page};
    List<OnlineRechargeModel> orderList = <OnlineRechargeModel>[];
    await ApiConfig.instance
        .get(onlineRechargeApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          orderList.add(OnlineRechargeModel.fromJson(data));
        });
      }
      result = {
        "dataList": orderList,
        'total': response.meta?['last_page'],
        'pageIndex': response.meta?['current_page']
      };
    });
    return result;
  }

  static Future<bool> rechargeAudit(id, Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .put('$rechargeAuditApi/$id', data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<RechargeModel?> getRechargeDetail(id) async {
    RechargeModel? result;
    await ApiConfig.instance.get('$rechargeApi/$id').then((response) {
      if (response.ok) {
        result = RechargeModel.fromJson(response.data);
      }
    });
    return result;
  }

  static Future<Map> getRechargeList([Map<String, dynamic>? params]) async {
    var page = (params is Map) ? params!['page'] : 1;
    Map result = {"dataList": null, 'total': 1, 'pageIndex': page};
    List<RechargeModel> orderList = <RechargeModel>[];
    await ApiConfig.instance
        .get(rechargeApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          orderList.add(RechargeModel.fromJson(data));
        });
      }
      result = {
        "dataList": orderList,
        'total': response.meta?['last_page'],
        'pageIndex': response.meta?['current_page']
      };
    });
    return result;
  }
}
