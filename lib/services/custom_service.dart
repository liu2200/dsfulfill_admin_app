import 'package:dsfulfill_admin_app/common/http_client.dart';
import 'package:dsfulfill_admin_app/models/custom_group_model.dart';
import 'package:dsfulfill_admin_app/models/customer_model.dart';

class CustomService {
  static const String customApi = 'custom';
  static const String customGroupApi = 'custom-group';
  static const String updateAutoPaymentApi = 'custom/update-auto-payment';
  static const String updateCreditLineApi = 'custom/update-credit-line';

  static Future<CustomerModel?> getCustomDetail(id) async {
    CustomerModel? result;
    await ApiConfig.instance.get('$customApi/$id').then((response) {
      if (response.ok) {
        result = CustomerModel.fromJson(response.data);
      }
    });
    return result;
  }

  static Future<bool> updateCreditLine(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(updateCreditLineApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<bool> updateCustom(id, Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .put('$customApi/$id', data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<bool> updateAutoPayment(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(updateAutoPaymentApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<Map> getCustomList([Map<String, dynamic>? params]) async {
    var page = (params is Map) ? params!['page'] : 1;
    Map result = {"dataList": null, 'total': 1, 'pageIndex': page};
    List<CustomerModel> orderList = <CustomerModel>[];
    await ApiConfig.instance
        .get(customApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          orderList.add(CustomerModel.fromJson(data));
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

  static Future<List<CustomGroupModel>> getCustomGroupList(
      Map<String, dynamic> params) async {
    List<CustomGroupModel> result = [];
    await ApiConfig.instance
        .get(customGroupApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(CustomGroupModel.fromJson(data));
        });
      }
    });
    return result;
  }
}
