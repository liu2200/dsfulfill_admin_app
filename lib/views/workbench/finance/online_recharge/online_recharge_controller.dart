import 'package:dsfulfill_cient_app/config/base_controller.dart';
import 'package:dsfulfill_cient_app/models/customer_model.dart';
import 'package:dsfulfill_cient_app/services/finance_service.dart';
import 'package:dsfulfill_cient_app/services/marketing_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRechargeController extends BaseController {
  final TextEditingController keywordController = TextEditingController();
  final RxString customerIdController = ''.obs; // 选中的客户id
  final RxString checkStatus = ''.obs;
  int pageIndex = 0;
  final currencyModel = Get.find<AppState>().currencyModel;
  final RxList<CustomerModel> clientList = <CustomerModel>[].obs; // 客户列表
  final Rx<DateTime?> filterStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> filterEndDate = Rx<DateTime?>(null);
  final operation = [
    {"label": "未核账", "id": "0"},
    {"label": "已核账", "id": "1"},
  ].obs; //轨迹

  @override
  void onInit() {
    super.onInit();
    getCustomList();
  }

  loadList({type}) async {
    pageIndex = 0;
    return await loadMoreList();
  }

  loadMoreList() async {
    Map<String, dynamic> dic = {
      "page": (++pageIndex),
      "serial_no": keywordController.text,
      "end_date": filterEndDate.value,
      "begin_date": filterStartDate.value,
      "customer_id": customerIdController.value,
      "check_status": checkStatus.value,
    };
    Map result = await FinanceService.getOnlineRechargeList(dic);
    return result;
  }

  getCustomList() async {
    var result = await MarketingService.getCustomList({
      'page': 1,
      'size': 1000,
    });
    clientList.value = result;
  }

  reset() {
    customerIdController.value = '';
    checkStatus.value = '';
    filterStartDate.value = null;
    filterEndDate.value = null;
    keywordController.text = '';
  }
}
