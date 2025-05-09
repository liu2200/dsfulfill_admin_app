import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/models/customer_model.dart';
import 'package:dsfulfill_cient_app/services/finance_service.dart';
import 'package:dsfulfill_cient_app/services/marketing_service.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeListController extends GetxController {
  final TextEditingController keywordController = TextEditingController();
  final RxString customerIdController = ''.obs; // 选中的客户id
  final RxString status = ''.obs;
  int pageIndex = 0;
  final currencyModel = Get.find<AppState>().currencyModel;
  final RxList<CustomerModel> clientList = <CustomerModel>[].obs; // 客户列表
  final Rx<DateTime?> filterStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> filterEndDate = Rx<DateTime?>(null);
  final operation = [
    {"label": "审核通过", "id": "1"},
    {"label": "待审核", "id": "2"},
  ].obs; //轨迹
  @override
  void onInit() {
    super.onInit();
    getCustomList();
    ApplicationEvent.getInstance().event.on<ListRefreshEvent>().listen((event) {
      if (event.type == 'refresh') {
        pageIndex = 0;
        loadList();
      }
    });
  }

  @override
  void onClose() {
    keywordController.dispose();
    super.onClose();
  }

  getCustomList() async {
    var result = await MarketingService.getCustomList({
      'page': 1,
      'size': 1000,
    });
    clientList.value = result;
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
      "status": status.value,
    };
    Map result = await FinanceService.getRechargeList(dic);
    return result;
  }

  reset() {
    customerIdController.value = '';
    status.value = '';
    filterStartDate.value = null;
    filterEndDate.value = null;
    keywordController.text = '';
  }
}
