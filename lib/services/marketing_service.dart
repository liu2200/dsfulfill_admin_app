import 'package:dsfulfill_admin_app/common/http_client.dart';
import 'package:dsfulfill_admin_app/models/customer_model.dart';
import 'package:dsfulfill_admin_app/models/staff_model.dart';

class MarketingService {
  static const String customListApi = 'custom'; //客户列表
  static const String staffListApi = 'members/staff-list'; //员工列表

  // 获取员工列表
  static Future<List<StaffModel>> getStaffList(
      Map<String, dynamic> params) async {
    List<StaffModel> result = [];
    await ApiConfig.instance
        .get(staffListApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(StaffModel.fromJson(data));
        });
      }
    });
    return result;
  }

  static Future<List<CustomerModel>> getCustomList(
      Map<String, dynamic> params) async {
    List<CustomerModel> result = [];
    await ApiConfig.instance
        .get(customListApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(CustomerModel.fromJson(data));
        });
      }
    });
    return result;
  }
}
