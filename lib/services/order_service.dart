import 'package:dsfulfill_admin_app/common/http_client.dart';

class OrderService {
  static const String removePrintApi = 'order/remove/print';
  static const String expressCompaniesApi = 'express-companies/place';
  static const String syncPlatformFulfillmentApi =
      'order/sync-platform-fulfillment';

  static Future<bool> syncPlatformFulfillment(params) async {
    bool result = false;
    await ApiConfig.instance
        .post(syncPlatformFulfillmentApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<bool> expressCompanies(params) async {
    bool result = false;
    await ApiConfig.instance
        .post(expressCompaniesApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  //移入配货中
  static Future<bool> removePrint(params) async {
    bool result = false;
    await ApiConfig.instance.put(removePrintApi, data: params).then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }
}
